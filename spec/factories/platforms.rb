FactoryBot.define do
  factory :platform do
    name { 'Rakuten' }
    image do
      Rack::Test::UploadedFile.new(Rails.root.join('public/test.png'), 'plat_form_rakuten.png')
    end

    factory :yahoo do
      name { 'yahoo' }
      image { Rack::Test::UploadedFile.new(Rails.root.join('public/test.png'), 'yahoo.png') }
    end

    initialize_with { Platform.find_or_create_by(name:) }
  end
end
