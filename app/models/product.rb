class Product < ApplicationRecord
  belongs_to :knowledge
  belongs_to :platform
  belongs_to :size

  validates :name, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :price, presence: true

  scope :by_size, ->(size) { where(size:) if size.present? }

  def self.sizes(knowledge_id)
    size_ids = where(knowledge_id:).distinct.pluck(:size_id)
    Size.find(size_ids)
  end
end
