FactoryBot.define do
  factory :user do
    name { 'MyString' }
    icon_url { 'MyString' }
    admin { false }
    provider { 'MyString' }
    uid { 'MyString' }
  end
end
