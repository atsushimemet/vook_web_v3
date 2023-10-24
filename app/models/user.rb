class User < ApplicationRecord
  has_many :knowledges, dependent: :destroy
  has_many :magazines, dependent: :destroy

  with_options presence: true do
    validates :name, length: { maximum: 100 }
    validates :uid
    validates :provider
    validates :profile, length: { maximum: 500 }
  end
  validates :uid, uniqueness: { scope: :provider }

  def self.find_or_create_from_auth_hash!(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    name = auth_hash[:info][:name]
    icon_url = auth_hash[:info][:image]

    User.find_or_create_by!(provider:, uid:) do |user|
      user.name = name
      user.icon_url = icon_url
    end
  end
end
