FactoryBot.define do
  factory :admin, class: 'User' do
    name { 'Admin' }
    icon_url { 'https://example.com/image' }
    admin { true }
    provider { 'google_oauth2' }
    uid { '1234' }
  end

  factory :non_admin, class: 'User' do
    name { 'Non Admin' }
    icon_url { 'https://example.com/image' }
    admin { false }
    provider { 'google_oauth2' }
    uid { '5678' }
  end
end
