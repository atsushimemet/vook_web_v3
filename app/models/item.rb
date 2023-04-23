class Item < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }

  has_many :line, dependent: :nullify
end
