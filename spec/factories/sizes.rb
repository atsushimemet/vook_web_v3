FactoryBot.define do
  factory :size do
    factory :size_w28 do
      name { 'w28' }
    end

    factory :size_w32 do
      name { 'w32' }
    end

    factory :size_M do
      name { 'M' }
    end

    initialize_with { Size.find_or_create_by(name:) }
  end
end
