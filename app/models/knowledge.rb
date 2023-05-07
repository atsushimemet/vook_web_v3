class Knowledge < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  validates :age, presence: true, numericality: { only_integer: true }

  belongs_to :brand
  belongs_to :item
  belongs_to :line
  has_one_attached :image
  has_rich_text :body
end
