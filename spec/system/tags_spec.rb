require 'rails_helper'

RSpec.describe '/tags', type: :system do
  let(:tag) { create(:tag) }
  let!(:magazine) { create(:magazine, tag_list: tag.name) }

  describe 'show' do
    it 'ブランド詳細ページが表示されること' do
      visit tag_path(tag.name)
      expect(page).to have_content tag.name
      expect(page).to have_content magazine.title
    end
  end
end
