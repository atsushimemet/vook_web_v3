FactoryBot.define do
  factory :line do
    brand
    item
    name { '501' }
    initialize_with { Line.find_or_create_by(name:) }
    image { Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/item-denim.jpg'), 'denim.jpg') }
  end
end
