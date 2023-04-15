class Magazine < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :publish_at, presence: true

  has_one_attached :thumbnail
end
