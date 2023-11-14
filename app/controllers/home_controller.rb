class HomeController < ApplicationController
  def index
    @first_brands = Brand.with_attached_image.limit(8)
    @more_brands = Brand.with_attached_image.offset(8)
    @first_items = Item.with_attached_image.limit(8)
    @more_items = Item.with_attached_image.offset(8)
    @items = Item.with_attached_image.all
    @magazines = Magazine.published.with_attached_thumbnail.order(publish_at: :desc).limit(8)
    @pickup_knowledges = current_pickup_knowledge
    @instagram_feeds = instagram_feed_cache
  end

  def about; end

  private

  # 本番環境で知識記事作られるまでの一時的なpickup
  def current_pickup_knowledge
    if Rails.env.production?
      Knowledge.with_attached_image.where(id: 10..14)
    else
      Knowledge.with_attached_image.where(id: 1..5)
    end
  end

  def instagram_feed_cache
    Rails.cache.fetch('instagram_feed', expires_in: 1.hour) do
      fetch_instagram_feed
    rescue StandardError => e
      Rails.logger.error("Error fetching Instagram feed: #{e.message}")
      []
    end
  end

  def fetch_instagram_feed
    uri = URI.parse("https://graph.facebook.com/v17.0/#{ENV['INSTAGRAM_ACCOUNT_ID']}/media?fields=caption,media_url,permalink&access_token=#{ENV['INSTA_TOKEN']}")
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)

    if json['data']
      json['data'][0..8]
    else
      Rails.logger.error("Instagram API did not return 'data': #{json}")
      []
    end
  end
end
