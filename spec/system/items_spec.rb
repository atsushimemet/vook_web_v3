require 'rails_helper'

RSpec.describe '/items', type: :system do
  let!(:item) { create(:item) }
  let!(:line) { create(:line, item:) }
  let!(:knowledge) { create(:knowledge, item:, line:) }

  describe 'show' do
    it 'ブランド詳細ページが表示されること' do
      visit item_path(item.name)
      expect(page).to have_content item.name
      expect(page).to have_content Line.first.name
    end
  end
end
