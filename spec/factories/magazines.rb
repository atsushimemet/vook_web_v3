FactoryBot.define do
  factory :magazine do
    user factory: :admin
    title { '【購入品紹介】"French Navy" Deck Jacket' }
    publish_at { Date.current }
    thumbnail { Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/map.jpg'), 'image/jpg') }
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
      publish_at { Date.current - 1 }
    end

    factory :day_before_yesterday_magazine do
      title { '公開日が一昨日の記事' }
      publish_at { Date.current - 2 }
    end

    factory :no_thumbnail_magazine do
      title { 'サムネイル画像がない記事' }
      thumbnail { nil }
    end
  end
end
