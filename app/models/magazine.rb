class Magazine < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :publish_at, presence: true

  has_one_attached :thumbnail
  has_rich_text :body
end
