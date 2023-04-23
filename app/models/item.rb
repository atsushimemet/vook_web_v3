class Item < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
end
