FactoryBot.define do
  factory :user do
    name { 'user' }
    icon_url { 'https://example.com/image' }
    admin { false }
    provider { 'google_oauth2' }
    sequence(:uid)

    factory :admin do
      name { 'admin user' }
      admin { true }
    end
  end
end
