PROPERTY_ID = ENV['GOOGLE_ANALYTICS_PROPERTY_ID']
CREDENTIALS_PATH = ENV['GOOGLE_APPLICATION_CREDENTIALS']

namespace :analytics do
  desc 'Fetch GA4 data and store in the database'
  task fetch_page_views: :environment do
    require 'google/analytics/data/v1beta'

    client = ::Google::Analytics::Data::V1beta::AnalyticsData::Client.new do |config|
      config.credentials = CREDENTIALS_PATH
    end

    unless PROPERTY_ID && CREDENTIALS_PATH
      raise 'Environment variables GOOGLE_ANALYTICS_PROPERTY_ID and GOOGLE_APPLICATION_CREDENTIALS must be set.'
    end

    response = fetch_ga4_response(client)

    ActiveRecord::Base.transaction do
      response.rows.each do |row|
        path = row.dimension_values[0].value
        date_range = row.dimension_values[1].value
        page_views = row.metric_values[0].value.to_i

        content_type, content_id = if path.start_with?('/magazine/')
                                     ['Magazine', path.split('/').last.to_i]
                                   elsif path.start_with?('/knowledges/')
                                     ['Knowledge', path.split('/').last.to_i]
                                   else
                                     next
                                   end

        PageView.find_or_initialize_by(content_type:, content_id:).tap do |page_view|
          page_view.monthly = page_views if date_range == 'Monthly'
          page_view.total = page_views if date_range == 'Total'
          page_view.save!
        end
      end
    rescue ActiveRecord::ActiveRecordError
      puts 'Database error occurred. Transaction has been rolled back.'
    end

    puts 'GA4 data successfully fetched and stored.'
  end

  def fetch_ga4_response(client)
    client.run_report(
      property: "properties/#{PROPERTY_ID}",
      dimensions: [Google::Analytics::Data::V1beta::Dimension.new(name: 'pagePath')],
      metrics: [Google::Analytics::Data::V1beta::Metric.new(name: 'screenPageViews')],
      date_ranges: [
        Google::Analytics::Data::V1beta::DateRange.new(name: 'Monthly', start_date: '30daysAgo', end_date: 'today'),
        Google::Analytics::Data::V1beta::DateRange.new(name: 'Total', start_date: '2024-01-01', end_date: 'today')
      ],
      dimension_filter: Google::Analytics::Data::V1beta::FilterExpression.new(
        filter: Google::Analytics::Data::V1beta::Filter.new(
          field_name: 'pagePath',
          string_filter: Google::Analytics::Data::V1beta::Filter::StringFilter.new(
            match_type: :FULL_REGEXP,
            value: '^(/magazine/[0-9]+|/knowledges/[0-9]+)$'
          )
        )
      )
    )
  rescue Google::Cloud::Error => e
    puts "Google API client error occurred: #{e.message}"
    raise
  end
end
