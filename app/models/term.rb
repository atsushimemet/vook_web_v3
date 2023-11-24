class Term < ApplicationRecord
  has_rich_text :description

  validates :name, presence: true, length: { maximum: 100 }
  validates :kana, presence: true, length: { maximum: 100 }
end
