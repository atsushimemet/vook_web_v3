lines = [
  {name: '501', brand: "Levi's", item: 'Denim Pants'},
  {name: '501XX', brand: "Levi's", item: 'Denim Pants'},
  {name: '551ZXX', brand: "Levi's", item: 'Denim Pants'},
  {name: '505', brand: "Levi's", item: 'Denim Pants'},
  {name: '606', brand: "Levi's", item: 'Denim Pants'},
  {name: '506XX', brand: "Levi's", item: 'Jacket'},
  {name: '507XX', brand: "Levi's", item: 'Jacket'},
  {name: '557XX', brand: "Levi's", item: 'Jacket'},
  {name: '557', brand: "Levi's", item: 'Jacket'},
  {name: '70505', brand: "Levi's", item: 'Jacket'},
  {name: 'SHORT HORN DENIM WESTERN', brand: "Levi's", item: 'Shirt'},
  {name: '27mw DENIM WESTERN', brand: 'Wrangler', item: 'Shirt'},
  {name: '91-J COVERALL', brand: 'Lee', item: 'Shirt'},
  {name: 'BOARD SHIRT', brand: 'Pendleton', item: 'Shirt'},
  {name: 'REVERSE WEAVE', brand: 'Champion', item: 'Sweat Shirt'},
  # {name: 'FATIGUE JACKET', brand: 'U.S.ARMY', item: 'Jacket'},
  # {name: 'M-65', brand: 'U.S.ARMY', item: 'Jacket'},
  # {name: 'MODS COAT', brand: 'U.S.ARMY', item: 'Jacket'},
  # {name: 'BOAT AND TOTE', brand: 'L.L.Bean', item: 'Bag'},
  # {name: 'M-65 FIELD Pants', brand: 'U.S.ARMY', item: 'Pants'},
]

lines.each do |line|
  brand = Brand.find_or_create_by!(name: line[:brand])
  item = Item.find_or_create_by!(name: line[:item])
  line = Line.find_or_create_by!(
    name: line[:name],
    brand_id: brand.id,
    item_id: item.id
  )

  case item.name
  when 'Denim Pants'
    image_path = 'line_denim_pants.jpg'
  when 'Jacket'
    image_path = 'line_jacket.png'
  when 'Shirt'
    image_path = 'line_shirt.png'
  when 'Sweat Shirt'
    image_path = 'line_sweat_shirt.png'
  end

  line.image.attach(io: File.open(Rails.root.join('app/assets/images/', image_path)), filename: image_path)
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

  knowledge = Knowledge.create!(name: 'ギャラ入り', age: 1955, user_id: user.id, brand_id: 1, item_id: 1, line_id: 1)
  knowledge.image.attach(io: File.open(Rails.root.join('app/assets/images/knowledge-501xx2.jpg')), filename: 'knowledge-501xx1.jpg')
  ActionText::RichText.create!(
    record_type: 'Knowledge',
    record_id: knowledge.id,
    name: 'body',
    body: "<div class=\"trix-content\">\n  <h1>紙パッチ</h1><div>1961年に製造されたギャラ入りは紙パッチ<br>「Every Garment Guaranteed」の表記から通称「ギャラ入り」と呼ばれ、<br>このモデルを象徴するディティールである。</div>\n</div>\n"
  )

  knowledge2 = Knowledge.create!(name: '片面タブ', age: 1947, user_id: user.id, brand_id: 1, item_id: 1, line_id: 1)
  knowledge2.image.attach(io: File.open(Rails.root.join('app/assets/images/knowledge-501xx1.jpg')), filename: 'knowledge-501xx2.jpg')
  ActionText::RichText.create!(
    record_type: 'Knowledge',
    record_id: knowledge2.id,
    name: 'body',
    body: "<div class=\"trix-content\">\n  <h1>赤タブ</h1><div>通称「片面タブ」<br>片面のみにLEVI’S刺繍が入る<br>このことからこのように呼ばれこのモデルの最大の特徴と言える。<br>製造年をとって別名「47モデル」とも呼ばれている</div>\n</div>\n"
  )
end
