FactoryBot.define do
  factory :knowledge do
    name { 'ギャラ入り' }
    age { 1955 }
    # image { Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/knowledge-501xx1.jpg'), '501xx.jpg') }
    after(:create) do |knowledge|
      ActionText::RichText.create!(
        record_type: 'Knowledge',
        record_id: knowledge.id,
        name: 'body',
        body: "<div class=\"trix-content\">\n  <h1>紙パッチ</h1><div>1961年に製造されたギャラ入りは紙パッチ<br>
              「Every Garment Guaranteed」の表記から通称「ギャラ入り」と呼ばれ、<br>このモデルを象徴するディティールである。</div>\n</div>\n"
      )
    end
  end
end
