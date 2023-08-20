FactoryBot.define do
  factory :item do
    name { 'Denim Pants' }
    initialize_with { Item.find_or_create_by(name:) }
  end
end
