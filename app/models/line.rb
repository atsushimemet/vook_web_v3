class Line < ApplicationRecord
  has_many :knowledges, dependent: :nullify
  belongs_to :brand
  belongs_to :item
  has_one_attached :image

  validates :name, presence: true, length: { maximum: 100 }

  def to_param
    name
  end

  scope :knowledge_count_order, lambda {
    left_joins(:knowledges)
      .group('lines.id')
      .order('COUNT(knowledges.id) DESC')
  }

  scope :with_published_knowledge, lambda {
    joins(:knowledges).where(knowledges: { status: Knowledge.statuses[:published] }).distinct
  }
end
