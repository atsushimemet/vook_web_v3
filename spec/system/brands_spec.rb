require 'rails_helper'

RSpec.describe '/brands', type: :system do
  let!(:brand) { create(:brand) }
  let!(:line) { create(:line, brand:) }
  let!(:knowledge) { create(:knowledge, brand:, line:) }

  describe 'show' do
    it 'ブランド詳細ページが表示されること' do
      visit brand_path(brand.name)
      expect(page).to have_content brand.name
      expect(page).to have_content Line.first.name
    end
  end
end
