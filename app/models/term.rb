class Term < ApplicationRecord
  has_many :term_categories, dependent: :destroy
  has_many :categories, dependent: :nullify, through: :term_categories
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :term_categories
  has_rich_text :description
  has_one_attached :image

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :kana, presence: true, length: { maximum: 100 }, uniqueness: true,
                   format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }

  KANA_GROUPS = {
    'ア行' => /[ァ-オ]/,
    'カ行' => /[カ-ゴ]/,
    'サ行' => /[サ-ゾ]/,
    'タ行' => /[タ-ド]/,
    'ナ行' => /[ナ-ノ]/,
    'ハ行' => /[ハ-ポ]/,
    'マ行' => /[マ-モ]/,
    'ヤ行' => /[ャ-ヨ]/,
    'ラ行' => /[ラ-ロ]/,
    'ワ行' => /[ワ-ン]/
  }.freeze

  def self.grouped_by_kana
    grouped_terms = all.group_by do |term|
      KANA_GROUPS.each do |group, regex|
        break group if term.kana[0].match?(regex)
      end
    end

    KANA_GROUPS.keys.each_with_object({}) do |group, result|
      result[group] = grouped_terms[group].sort_by(&:kana) if grouped_terms.key?(group)
    end
  end
end
