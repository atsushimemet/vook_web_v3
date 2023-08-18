class Platform < ApplicationRecord
  has_many :products, dependent: :nullify
  has_one_attached :image

  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
end
