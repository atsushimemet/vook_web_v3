FactoryBot.define do
  factory :platform do
    name { 'Rakuten' }
    image do
      Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/platform_rakuten.png'), 'plat_form_rakuten.png')
    end

    factory :yahoo do
      name { 'yahoo' }
      image { Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/platform_yahoo.png'), 'yahoo.png') }
    end

    initialize_with { Platform.find_or_create_by(name:) }
  end
end
