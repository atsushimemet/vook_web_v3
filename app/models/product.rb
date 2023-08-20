class Product < ApplicationRecord
  belongs_to :knowledge
  belongs_to :platform
  belongs_to :size

  validates :name, presence: true
  validates :url, presence: true, uniqueness: true
  validates :price, presence: true

  scope :by_size, ->(size) { where(size:) if size.present? }
end
