class Platform < ApplicationRecord
  has_many :products, dependent: :nullify

  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
end
