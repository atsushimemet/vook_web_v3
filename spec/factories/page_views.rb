FactoryBot.define do
  factory :page_view do
    content_type { 'magazine' }
    content_id { 1 }
    monthly { 10 }
    total { 100 }
  end
end
