class Category < ApplicationRecord
  has_many :term_categories, dependent: :destroy
  has_many :terms, dependent: :nullify, through: :term_categories

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
end
