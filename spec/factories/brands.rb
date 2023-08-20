FactoryBot.define do
  factory :brand do
    name { "Levi's" }
    initialize_with { Brand.find_or_create_by(name:) }
  end
end
