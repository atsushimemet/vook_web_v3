class Knowledge < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  belongs_to :item
  belongs_to :line
  has_many :products, dependent: :destroy
  has_one_attached :image
  has_rich_text :body

  validates :name, presence: true, length: { maximum: 100 }
  validates :age, presence: true, numericality: { only_integer: true }

  enum status: { draft: 0, published: 1 }

  def related_knowledges
    Knowledge.with_attached_image.where(line_id:).where.not(id:).limit(4)
  end
end
