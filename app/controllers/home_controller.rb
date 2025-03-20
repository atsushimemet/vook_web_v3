class HomeController < ApplicationController
  def index
    @headline_contents = fetch_headline_contents
    @ranking_magazines = Magazine.ranking.includes(:tags, thumbnail_attachment: :blob).limit(4).presence ||
                         Magazine.published.includes(:tags, thumbnail_attachment: :blob)
                                 .order(publish_at: :desc).limit(4)
    # TODO: 広告マガジンが決まったらidを指定
    # @ad_magazine = Magazine.includes(:tags, thumbnail_attachment: :blob).order(publish_at: :desc).find(X)
    @first_brands = Brand.includes(image_attachment: :blob).order(:display_order).limit(8)
    @more_brands = Brand.includes(image_attachment: :blob).order(:display_order).offset(8)
    @first_items = Item.includes(image_attachment: :blob).knowledge_count_order.limit(8)
    @more_items = Item.includes(image_attachment: :blob).knowledge_count_order.offset(8)
    @magazines = Magazine.published.includes(thumbnail_attachment: :blob).order(publish_at: :desc).limit(8)
    # levis 501 BIG E, id 10
    # champion reverse weave 90s 刺繍タグ, id 50
    # levis 501 66前期, id 5
    # lee 101j 101j, id 107
    # levis 505 BIG E, id 33
    @pickup_product_knowledges = Knowledge.includes(:brand, :products,
                                                    line: { image_attachment: :blob }).where(id: [10, 50, 5, 107, 33])
    @instagram_feeds = instagram_feed_cache
  end

  def about; end

  private

  def fetch_headline_contents
    [
      { title: '用語一覧ページ', image_url: 'headline_terms.webp', link: '/terms' },
      { title: 'インスタグラム', image_url: 'headline_instagram.webp', link: 'https://www.instagram.com/vook.vintagebook/' },
      { title: 'BIG Eの知識ページ', image_url: 'headline_knowledge.webp', link: '/knowledges/10' },
      { title: 'Vook tokyoとは', image_url: 'headline_about_vook.webp', link: '/about' }
    ]
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
    uri = URI.parse("https://graph.facebook.com/v22.0/#{ENV['INSTAGRAM_ACCOUNT_ID']}/media?fields=caption,media_url,permalink,media_type&access_token=#{ENV['INSTA_TOKEN']}")
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)

    if json['data']
      json['data'].select { |media| media['media_type'] == 'CAROUSEL_ALBUM' }.first(9)
    else
      Rails.logger.error("Instagram API did not return 'data': #{json}")
      []
    end
  end
end
