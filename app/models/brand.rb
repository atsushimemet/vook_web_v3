class Brand < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }

  has_many :knowledges, dependent: :nullify
  has_many :items, dependent: :nullify, through: :lines
  has_many :lines, dependent: :nullify
  has_one_attached :logo
end
