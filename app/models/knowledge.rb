class Knowledge < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  belongs_to :item
  belongs_to :line
  has_many :products, dependent: :nullify
  has_one_attached :image
  has_rich_text :body

  validates :name, presence: true, length: { maximum: 100 }
  validates :age, presence: true, numericality: { only_integer: true }

  def name_with_brand_and_line
    "#{name} | #{brand.name} | #{line.name}"
  end
end
