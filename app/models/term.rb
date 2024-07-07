class Term < ApplicationRecord
  has_many :term_categories, dependent: :destroy
  has_many :categories, dependent: :nullify, through: :term_categories
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :term_categories
  has_rich_text :description
  has_one_attached :image

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :kana, presence: true, length: { maximum: 100 }, uniqueness: true

  KANA_GROUPS = {
    'ア行' => 'ア'..'オ',
    'カ行' => 'カ'..'コ',
    'サ行' => 'サ'..'ソ',
    'タ行' => 'タ'..'ト',
    'ナ行' => 'ナ'..'ノ',
    'ハ行' => 'ハ'..'ホ',
    'マ行' => 'マ'..'モ',
    'ヤ行' => 'ヤ'..'ヨ',
    'ラ行' => 'ラ'..'ロ',
    'ワ行' => 'ワ'..'ン'
  }.freeze

  def self.grouped_by_kana
    KANA_GROUPS.transform_values do |range|
      where(kana: range).order(:kana)
    end
  end
end
