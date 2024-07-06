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
    'あ行' => 'ア'..'オ',
    'か行' => 'カ'..'コ',
    'さ行' => 'サ'..'ソ',
    'た行' => 'タ'..'ト',
    'な行' => 'ナ'..'ノ',
    'は行' => 'ハ'..'ホ',
    'ま行' => 'マ'..'モ',
    'や行' => 'ヤ'..'ヨ',
    'ら行' => 'ラ'..'ロ',
    'わ行' => 'ワ'..'ン'
  }.freeze

  def self.grouped_by_kana
    KANA_GROUPS.transform_values do |range|
      where(kana: range).order(:kana)
    end
  end
end
