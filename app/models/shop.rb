class Shop < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
