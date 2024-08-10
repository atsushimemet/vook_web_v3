FactoryBot.define do
  factory :term do
    name { '赤耳' }
    kana { 'アカミミ' }

    after(:create) do |term|
      ActionText::RichText.create!(
        record_type: 'Term',
        record_id: term.id,
        name: 'description',
        body: '<div>サイドシームを折り返した際の赤いステッチのこと</div><div>サイドシームにある生地の端の解れ（ほつれ）を防止するために存在している</div><div>同義語, セルビッチ</div>'
      )
    end

    factory :image_term do
      name { 'ギャラ' }
      kana { 'ギャラ' }
      image { Rack::Test::UploadedFile.new(Rails.root.join('public/test.png'), 'image/jpg') }
    end
  end
end
