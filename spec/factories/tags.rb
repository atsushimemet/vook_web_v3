FactoryBot.define do
  factory :tag, class: 'ActsAsTaggableOn::Tag' do
    name { '東京' }
    taggings_count { 5 }
  end
end
