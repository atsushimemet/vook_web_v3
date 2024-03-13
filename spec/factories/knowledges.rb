FactoryBot.define do
  factory :knowledge do
    user factory: :admin
    line
    brand { line.brand }
    item { line.item }

    name { '66前期' }
    age { 1955 }
    status { 'published' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('public/test.png'), '501xx.jpg') }
    after(:create) do |knowledge|
      ActionText::RichText.create!(
        record_type: 'Knowledge',
        record_id: knowledge.id,
        name: 'body',
        body: "<div class=\"trix-content\">\n  <h1>Age</h1><ul><li>1974 ~ 1977</li></ul><h1>ディテール</h1><ul><li>
              <strong>ボタン</strong><ul><li>フロントボタン</li><li>※ ウエストサイズによって、フロントボタンの数が異なる。<ul>
              <li>~W29, 4個</li><li>W30 ~ W40, 5個</li><li>W42 ~, 6個</li></ul></li></ul>\n</div>\n"
      )
    end
  end

  factory :no_image_knowledge, class: 'Knowledge' do
    user factory: :admin
    line
    brand { line.brand }
    item { line.item }

    name { 'イメージ画像がない知識' }
    age { 1955 }
    status { 'published' }
    after(:create) do |knowledge|
      ActionText::RichText.create!(
        record_type: 'Knowledge',
        record_id: knowledge.id,
        name: 'body',
        body: 'この知識にはイメージがありません'
      )
    end
  end
end
