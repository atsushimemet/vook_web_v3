class Term < ApplicationRecord
  has_many :term_categories, dependent: :destroy
  has_many :categories, dependent: :nullify, through: :term_categories
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :term_categories
  has_rich_text :description
  has_one_attached :image

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :kana, presence: true, length: { maximum: 100 }, uniqueness: true
end
