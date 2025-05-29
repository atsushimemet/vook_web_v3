class Shop < ApplicationRecord
  has_one :image_credit, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
