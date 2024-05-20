require 'rails_helper'

RSpec.describe 'Terms::Categories', type: :system do
  let(:category) { create(:category) }
  let(:term) { create(:term) }
  let!(:term_category) { create(:term_category, term:, category:) }

  describe 'show' do
    it 'カテゴリ名をパラメータとして送ると、そのカテゴリに関連する項目が表示されること' do
      visit terms_category_path(category_name: category.name)
      expect(page).to have_content category.name
      expect(page).to have_content term.name
    end
  end
end
