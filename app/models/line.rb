class Line < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }

  has_many :knowledges, dependent: :nullify
  belongs_to :brand
  belongs_to :item
  has_one_attached :image
end
