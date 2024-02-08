FactoryBot.define do
  factory :magazine do
    user factory: :admin
    title { '【購入品紹介】"French Navy" Deck Jacket' }
    publish_at { Time.current }
    thumbnail { Rack::Test::UploadedFile.new(Rails.root.join('public/test.png'), 'image/jpg') }
    after(:create) do |magazine|
      ActionText::RichText.create!(
        record_type: 'Magazine',
        record_id: magazine.id,
        name: 'body',
        body: "<div class=\"trix-content\">\n  <div>90年代のフランス海軍デッキジャケット</div>\n</div>\n"
      )
    end

    factory :yesterday_magazine do
      title { '公開日が昨日の記事' }
      publish_at { Time.current.yesterday }
    end

    factory :day_before_yesterday_magazine do
      title { '公開日が一昨日の記事' }
      publish_at { Time.current.ago(2.days) }
    end

    factory :no_thumbnail_magazine do
      title { 'サムネイル画像がない記事' }
      thumbnail { nil }
    end

    factory :draft do
      title { '下書きの記事' }
      publish_at { nil }
    end

    factory :scheduled do
      title { '予約投稿の記事' }
      publish_at { Time.current + 10.minutes }
    end
  end
end
