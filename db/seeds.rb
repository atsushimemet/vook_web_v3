if Rails.env.development?
  7.times do |i|
    Magazine.create(
      title: '【購入品紹介】 "French Navy" Deck Jacket',
      summary: '',
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

  lines = [
    {name: '501XX', brand: "Levi's", item: 'Denim'},
    {name: '606 BIG E', brand: "Levi's", item: 'Denim'},
    {name: '551ZXX', brand: "Levi's", item: 'Denim'},
    {name: '501 BLACK', brand: "Levi's", item: 'Denim'},
    {name: 'FATIGUE JACKET', brand: 'U.S.ARMY', item: 'Jacket'},
    {name: 'M-65', brand: 'U.S.ARMY', item: 'Jacket'},
    {name: 'MODS COAT', brand: 'U.S.ARMY', item: 'Jacket'},
    {name: 'BOAT AND TOTE', brand: 'L.L.Bean', item: 'Bag'},
    {name: 'M-65 FIELD Pants', brand: 'U.S.ARMY', item: 'Pants'},
    {name: '70505 4th', brand: "Levi's", item: 'Jacket'},
    {name: 'REVERSE WEAVE', brand: 'Champion', item: 'Sweat'},
  ]

  lines.each do |line|
    Brand.find_or_create_by!(name: line[:brand])
    Item.find_or_create_by!(name: line[:item])
    Line.create!(
      name: line[:name],
      brand_id: Brand.find_by(name: line[:brand]).id,
      item_id: Item.find_by(name: line[:item]).id
    ).image.attach(io: File.open(Rails.root.join('app/assets/images/line-501xx.jpg')), filename: 'line-501xx.jpg')
  end

  knowledge = Knowledge.create!(name: 'ギャラ入り', age: 1955, brand_id: 1, item_id: 1, line_id: 1)
  knowledge.image.attach(io: File.open(Rails.root.join('app/assets/images/knowledge-501xx2.jpg')), filename: 'knowledge-501xx1.jpg')
  ActionText::RichText.create!(
    record_type: 'Knowledge',
    record_id: knowledge.id,
    name: 'body',
    body: "<div class=\"trix-content\">\n  <h1>紙パッチ</h1><div>1961年に製造されたギャラ入りは紙パッチ<br>「Every Garment Guaranteed」の表記から通称「ギャラ入り」と呼ばれ、<br>このモデルを象徴するディティールである。</div>\n</div>\n"
  )

  knowledge2 = Knowledge.create!(name: '片面タブ', age: 1947, brand_id: 1, item_id: 1, line_id: 1)
  knowledge2.image.attach(io: File.open(Rails.root.join('app/assets/images/knowledge-501xx1.jpg')), filename: 'knowledge-501xx2.jpg')
  ActionText::RichText.create!(
    record_type: 'Knowledge',
    record_id: knowledge2.id,
    name: 'body',
    body: "<div class=\"trix-content\">\n  <h1>赤タブ</h1><div>通称「片面タブ」<br>片面のみにLEVI’S刺繍が入る<br>このことからこのように呼ばれこのモデルの最大の特徴と言える。<br>製造年をとって別名「47モデル」とも呼ばれている</div>\n</div>\n"
  )
end
