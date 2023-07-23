class Product < ApplicationRecord
  belongs_to :knowledge
  belongs_to :platform
  belongs_to :size

  validates :name, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :price, presence: true
end
