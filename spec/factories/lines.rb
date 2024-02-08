FactoryBot.define do
  factory :line do
    brand
    item
    name { '501' }
    initialize_with { Line.find_or_create_by(name:) }
    image { Rack::Test::UploadedFile.new(Rails.root.join('public/test.png'), 'denim.jpg') }
  end
end
