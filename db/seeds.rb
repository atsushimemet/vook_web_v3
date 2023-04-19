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
end
