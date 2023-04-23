class Line < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }

  belongs_to :brand
  belongs_to :item
end
