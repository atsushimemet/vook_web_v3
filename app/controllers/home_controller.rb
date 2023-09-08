class HomeController < ApplicationController
  def index
    @brands = Brand.all
    @items = Item.all
    @magazines = Magazine.with_attached_thumbnail.order(publish_at: :desc).limit(8)
    # 本番環境で知識記事作られるまでidが10-14のものを表示させる
    @pickup_knowledges = Knowledge.where(id: 10..14)
    @instagram_feeds = instagram_feed_cache
  end

  def about; end

  private

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
