FactoryBot.define do
  factory :product do
    knowledge
    size factory: :size_w28
    platform

    name { "リーバイス 501 ネイビー LEVI'S 66前期 BIGE 初期 w28 001" }
    url { 'https://item.rakuten.co.jp/wego-vintage/001/' }
    price { 82_500 }

    factory :product2 do
      size factory: :size_w32

      name { "リーバイス 501 ネイビー LEVI'S 66前期 BIGE 初期 w32 002" }
      url { 'https://item.rakuten.co.jp/wego-vintage/002/' }
      price { 60_500 }
    end
  end
end
