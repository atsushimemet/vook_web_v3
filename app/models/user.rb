class User < ApplicationRecord
  with_options presence: true do
    validates :name, presence: true, length: {maximum: 100}
    validates :admin
    validates :uid
    validates :provider
  end
  validates :uid, uniqueness: { scope: :provider }
end
