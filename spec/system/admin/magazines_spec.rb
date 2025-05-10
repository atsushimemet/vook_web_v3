require 'rails_helper'

RSpec.describe '/magazines', type: :system do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let!(:magazine) { create(:magazine) }

  describe 'index' do
    it '管理者は表示されること' do
      sign_in_as(admin)
      visit admin_magazines_path
      expect(page).to have_content 'Magazine'
    end

    it '管理者以外は表示されないこと' do
      sign_in_as(user)
      visit admin_magazines_path
      expect(page).to have_content '管理者としてログインしてください'
    end
  end
end
