class Item < ApplicationRecord
  has_many :knowledges, dependent: :nullify
  has_many :brands, dependent: :nullify, through: :lines
  has_many :lines, dependent: :nullify
  has_one_attached :image
  has_one_attached :banner

  validates :name, presence: true, length: { maximum: 100 }
end
