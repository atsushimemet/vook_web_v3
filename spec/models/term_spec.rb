require 'rails_helper'

RSpec.describe Term, type: :model do
  describe 'grouped_by_kana' do
    let!(:term_akamimi) { create(:term) }
    let!(:term_migiaya) { create(:term, name: '右綾', kana: 'ミギアヤ') }

    it 'ア行の用語を取得できること' do
      expect(described_class.grouped_by_kana['ア行']).to include term_akamimi
    end

    it 'マ行の用語を取得できること' do
      expect(described_class.grouped_by_kana['マ行']).to include term_migiaya
    end
  end
end
