class Brand < ApplicationRecord
  has_many :knowledges, dependent: :nullify
  has_many :lines, dependent: :nullify
  has_many :items, dependent: :nullify, through: :lines
  has_one_attached :image
  has_one_attached :banner

  validates :name, presence: true, length: { maximum: 100 }

  def to_param
    name
  end
end
