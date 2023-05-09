class Magazine < ApplicationRecord
  belongs_to :user
  has_one_attached :thumbnail
  has_rich_text :body

  validates :title, presence: true, length: { maximum: 255 }
  validates :publish_at, presence: true
end
