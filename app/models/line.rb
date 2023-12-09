class Line < ApplicationRecord
  has_many :knowledges, dependent: :nullify
  belongs_to :brand
  belongs_to :item
  has_one_attached :image

  validates :name, presence: true, length: { maximum: 100 }

  def to_param
    name
  end
end
