FactoryBot.define do
  factory :magazine do
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
  end

  factory :yesterday_magazine, class: 'Magazine' do
    title { '公開日が機能の記事' }
    publish_at { Date.current - 1 }
    thumbnail { Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/map.jpg'), 'image/jpg') }
    after(:create) do |magazine|
      ActionText::RichText.create!(
        record_type: 'Magazine',
        record_id: magazine.id,
        name: 'body',
        body: "<div class=\"trix-content\">\n  <div>`#{Date.current - 1}`の記事</div>\n</div>\n"
      )
    end
  end

  factory :tomorrow_magazine, class: 'Magazine' do
    title { '公開日が明日の記事' }
    publish_at { Date.current + 1 }
    thumbnail { Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/map.jpg'), 'image/jpg') }
    after(:create) do |magazine|
      ActionText::RichText.create!(
        record_type: 'Magazine',
        record_id: magazine.id,
        name: 'body',
        body: "<div class=\"trix-content\">\n  <div>`#{Date.current + 1}`の記事</div>\n</div>\n"
      )
    end
  end
end
