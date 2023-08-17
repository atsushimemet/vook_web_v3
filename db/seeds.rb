lines = [
  { name: '501', brand: "Levi's", item: 'Denim Pants' },
  { name: '501XX', brand: "Levi's", item: 'Denim Pants' },
  { name: '551ZXX', brand: "Levi's", item: 'Denim Pants' },
  { name: '505', brand: "Levi's", item: 'Denim Pants' },
  { name: '606', brand: "Levi's", item: 'Denim Pants' },
  { name: '506XX', brand: "Levi's", item: 'Jacket' },
  { name: '507XX', brand: "Levi's", item: 'Jacket' },
  { name: '557XX', brand: "Levi's", item: 'Jacket' },
  { name: '557', brand: "Levi's", item: 'Jacket' },
  { name: '70505', brand: "Levi's", item: 'Jacket' },
  { name: 'SHORT HORN DENIM WESTERN', brand: "Levi's", item: 'Shirt' },
  { name: '27mw DENIM WESTERN', brand: 'Wrangler', item: 'Shirt' },
  { name: '91-J COVERALL', brand: 'Lee', item: 'Jacket' },
  { name: 'BOARD SHIRT', brand: 'Pendleton', item: 'Shirt' },
  { name: 'REVERSE WEAVE', brand: 'Champion', item: 'Sweat Shirt' },
  { name: 'FATIGUE JACKET', brand: 'U.S.ARMY', item: 'Jacket' },
  { name: 'M-65', brand: 'U.S.ARMY', item: 'Jacket' },
  { name: 'MODS COAT', brand: 'U.S.ARMY', item: 'Coat' },
  { name: 'BOAT AND TOTE', brand: 'L.L.Bean', item: 'Bag' },
  { name: 'M-65 FIELD Pants', brand: 'U.S.ARMY', item: 'Pants' }
]

lines.each do |line|
  brand = Brand.find_or_create_by!(name: line[:brand])
  item = Item.find_or_create_by!(name: line[:item])
  line = Line.find_or_create_by!(name: line[:name], brand_id: brand.id, item_id: item.id)

  image_path = case item.name
               when 'Denim Pants' then 'line_denim_pants.jpg'
               when 'Jacket' then 'line_jacket.png'
               when 'Shirt' then 'line_shirt.png'
               when 'Sweat Shirt' then 'line_sweat_shirt.png'
               when 'Bag' then 'line_bag.png'
               when 'Pants' then 'line_pants.png'
               when 'Coat' then 'line_coat.png'
               end

  line.image.attach(io: File.open(Rails.root.join("app/assets/images/#{image_path}")), filename: image_path)
end

if Rails.env.development?
  user = User.create!(name: 'admin', icon_url: 'https://1.bp.blogspot.com/-bAOIfmOoIvI/VY4WmqzWeVI/AAAAAAAAusA/wpJ8Jc1VgZ0/s800/job_kanrinin.png', admin: true, provider: 'google_oauth2', uid: 1234)

  7.times do |i|
    Magazine.create(
      title: '【購入品紹介】 "French Navy" Deck Jacket',
      summary: '',
      user_id: user.id,
      publish_at: Date.current - i.day
    ).thumbnail.attach(io: File.open(Rails.root.join('app/assets/images/map.jpg')), filename: 'map.jpg')
  end
  Magazine.all.each do |magazine|
    ActionText::RichText.create!(
      record_type: 'Magazine',
      record_id: magazine.id,
      name: 'body',
      body: "#{magazine.id} <div class=\"trix-content\">\n  <div>90年代のフランス海軍デッキジャケット<br>海軍らしい紺色とUSとはまた違った雰囲気が良く、ユーズドショップにて購入。古着っぽくなりすぎないよう下はスラックスとローファー、全体色はネイビー×ホワイトの組み合わせにしてキレイめに中和したつもりです。□Tops / French Navy Deck Jacket<br>□Watch / rolex explore1<br>□Bottoms / steven alan<br>□Shoes / Hiroshi Tsubouchi</div>\n</div>\n"
    )
  end

  levis = Brand.find_by(name: "Levi's")
  bean = Brand.find_by(name: 'L.L.Bean')
  army = Brand.find_by(name: 'U.S.ARMY')
  denim = Item.find_by(name: 'Denim Pants')
  jacket = Item.find_by(name: 'Jacket')
  bag = Item.find_by(name: 'Bag')
  levis501 = Line.find_by(name: '501')
  boat_and_tote = Line.find_by(name: 'BOAT AND TOTE')
  m65 = Line.find_by(name: 'M-65')
  levis501xx = Line.find_by(name: '501XX')

  knowledges_obj = [
    {
      name: '66前期', age: 1955, brand_id: levis.id, item_id: denim.id, line_id: levis501.id
    },
    {
      name: '1970年代', age: 1955, brand_id: bean.id, item_id: bag.id, line_id: boat_and_tote.id
    },
    {
      name: 'FIELD JACKET 1st 1960年代', age: 1955, brand_id: army.id, item_id: jacket.id, line_id: m65.id
    },
    {
      name: 'BIG E 初期', age: 1955, brand_id: levis.id, item_id: denim.id, line_id: levis501.id
    },
    {
      name: 'BIG E 後期', age: 1955, brand_id: levis.id, item_id: denim.id, line_id: levis501.id
    },
    {
      name: '片面タブ', age: 1955, brand_id: levis.id, item_id: denim.id, line_id: levis501xx.id
    }
  ]

  knowledges_obj.each do |obj|
    knowledge = Knowledge.create!(obj.merge(user_id: user.id))
    knowledge.image.attach(io: File.open(Rails.root.join('app/assets/images/knowledge-501xx1.jpg')),
                           filename: 'knowledge-501xx1.jpg')
    ActionText::RichText.create!(
      record_type: 'Knowledge',
      record_id: knowledge.id,
      name: 'body',
      body: "<div class=\"trix-content\">\n  <h1>知識記事</h1><div>1961年に製造されたギャラ入りは紙パッチ<br>「Every Garment Guaranteed」の表記から通称「ギャラ入り」と呼ばれ、<br>このモデルを象徴するディティールである。</div>\n</div>\n"
    )
  end

  7.times do |i|
    Size.create!(name: "w#{28 + i}")
    Size.create!(name: 34 + i * 2)
  end

  %w[XS S M L XL].each do |name|
    Size.create!(name:)
  end

  %w[Rakuten Yahoo BASE].each do |name|
    platform = Platform.create!(name:)

    image_path = "platform_#{platform.name.downcase}.png"
    platform.image.attach(io: File.open(Rails.root.join("app/assets/images/#{image_path}")), filename: image_path)
  end

  products = [
    {
      name: "60～70's Levi's 805 66single USA製 デニムパンツ W31 60年代 60s 70年代 70s リーバイス 66前期 インディゴ アメリカ製 【古着】 【ヴィンテージ】 【中古】 【メンズ店】",
      url: 'https://item.rakuten.co.jp/feeetvintageclothing/113394/',
      price: 43_890,
      knowledge_id: Knowledge.find(1).id,
      platform_id: Platform.find_by(name: 'Rakuten').id,
      size_id: Size.find_by(name: 'w31').id
    },
    {
      name: "60～70's Levi's 805 66single USA製 デニムパンツ W31 60年代 60s 70年代 70s リーバイス 66前期 インディゴ アメリカ製 【古着】 【ヴィンテージ】 【中古】",
      url: 'https://example.com/',
      price: 40_000,
      knowledge_id: Knowledge.find(1).id,
      platform_id: Platform.find_by(name: 'Rakuten').id,
      size_id: Size.find_by(name: 'w31').id
    },
    {
      name: "60～70's Levi's 805 66single USA製 デニムパンツ W31 60年代 60s 70年代 70s リーバイス 66前期 インディゴ アメリカ製 【古着】 【ヴィンテージ】",
      url: 'https://example.net/',
      price:50_000,
      knowledge_id: Knowledge.find(1).id,
      platform_id: Platform.find_by(name: 'Yahoo').id,
      size_id: Size.find_by(name: 'w31').id
    },
    {
      name: "60～70's Levi's 805 66single USA製 デニムパンツ W31 60年代 60s 70年代 70s リーバイス 66前期 インディゴ アメリカ製 【古着】",
      url: 'https://example.org/',
      price: 60_000,
      knowledge_id: Knowledge.find(1).id,
      platform_id: Platform.find_by(name: 'BASE').id,
      size_id: Size.find_by(name: 'w31').id
    },
    {
      name: "60～70's Levi's 805 66single USA製 デニムパンツ W32 60年代 60s 70年代 70s リーバイス 66前期 インディゴ アメリカ製 【古着】 【ヴィンテージ】 【中古】 【メンズ店】",
      url: 'https://example.com1/',
      price: 43_890,
      knowledge_id: Knowledge.find(1).id,
      platform_id: Platform.find_by(name: 'Rakuten').id,
      size_id: Size.find_by(name: 'w32').id
    },
    {
      name: "60～70's Levi's 805 66single USA製 デニムパンツ W33 60年代 60s 70年代 70s リーバイス 66前期 インディゴ アメリカ製 【古着】 【ヴィンテージ】 【中古】 【メンズ店】",
      url: 'https://example.com2/',
      price: 43_890,
      knowledge_id: Knowledge.find(1).id,
      platform_id: Platform.find_by(name: 'Yahoo').id,
      size_id: Size.find_by(name: 'w33').id
    },
    {
      name: "60～70's Levi's 805 66single USA製 デニムパンツ W34 60年代 60s 70年代 70s リーバイス 66前期 インディゴ アメリカ製 【古着】 【ヴィンテージ】 【中古】 【メンズ店】",
      url: 'https://example.com3/',
      price: 43_890,
      knowledge_id: Knowledge.find(1).id,
      platform_id: Platform.find_by(name: 'BASE').id,
      size_id: Size.find_by(name: 'w34').id
    },
    {
      name: '【中古】L.L.Bean◆オールド/トートバッグ/キャンバス/70S後期タグ/ラージトート/レザーハンドル/大容量【バッグ】',
      url: 'https://item.rakuten.co.jp/jumblestore/2335232285580/',
      price: 19_690,
      knowledge_id: Knowledge.find(2).id,
      platform_id: Platform.find_by(name: 'Rakuten').id,
      size_id: Size.find_by(name: 'M').id
    },
    {
      name: '【中古】60s 米軍 実物 U.S.ARMY M-65 フィールド ジャケット 1st ミリタリー(MEDIUM-LONG)l7688',
      url: 'https://item.rakuten.co.jp/heb-webstore/l7688/',
      price: 27_500,
      knowledge_id: Knowledge.find(3).id,
      platform_id: Platform.find_by(name: 'Rakuten').id,
      size_id: Size.find_by(name: 38).id
    },
    {
      name: "リーバイス 501 ネイビー LEVI'S 66前期 BIGE 初期 Vステッチ ウエストシングル VINTAGE ヴィンテージ ジーンズ デニムパンツ　ビッグE 古着 【中古】　wv1912-0165",
      url: 'https://item.rakuten.co.jp/wego-vintage/wv1912-0165/',
      price: 82_500,
      knowledge_id: Knowledge.find(4).id,
      platform_id: Platform.find_by(name: 'Yahoo').id,
      size_id: Size.find_by(name: 'w29').id
    },
    {
      name: 'LEVIS VINTAGE 60-70S オリジナル 501 BIG-E 後期 リーバイス ヴィンテージ ビッグイー デニム パンツ 大名店【中古】',
      url: 'https://item.rakuten.co.jp/ec-union3/da220129-13/',
      price: 50_600,
      knowledge_id: Knowledge.find(5).id,
      platform_id: Platform.find_by(name: 'Yahoo').id,
      size_id: Size.find_by(name: 'w32').id
    },
    {
      name: "40～50's LEVI'S 501XX 1947model 片面タブ 革パッチ デニムパンツ W31 40年代 40s 50年代 50s リーバイス インディゴ 赤耳 セルヴィッチ セルビッチ 銅リベット 【古着】 【ヴィンテージ】 【中古】 【メンズ店】",
      url: 'https://item.rakuten.co.jp/feeetvintageclothing/119919/',
      price: 327_800,
      knowledge_id: Knowledge.find(6).id,
      platform_id: Platform.find_by(name: 'BASE').id,
      size_id: Size.find_by(name: 'w31').id
    }
  ]

  products.each do |product|
    Product.create!(product)
  end

  puts 'seedデータを投入しました'
end
