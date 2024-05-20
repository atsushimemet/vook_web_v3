require 'rails_helper'

RSpec.describe '/categories', type: :system do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let!(:category) { create(:category) }

  describe 'index' do
    it '管理者がカテゴリ一覧ページにアクセスできること' do
      sign_in_as(admin)
      visit categories_path
      expect(page).to have_content 'Category'
    end

    it '管理者以外がカテゴリ一覧ページにアクセスしようとするとリダイレクトされること' do
      sign_in_as(user)
      visit categories_path
      expect(page).to have_content '管理者としてログインしてください'
    end
  end

  describe 'update' do
    it 'カテゴリ詳細ページからカテゴリの編集ができること' do
      sign_in_as(admin)
      visit edit_category_path(category)
      expect do
        fill_in 'category_name', with: '変更カテゴリ'
        click_on '更新'
        expect(page).to have_content 'カテゴリーを更新しました'
      end.to change(Category, :count).by(0)
    end
  end

  describe 'destroy' do
    it 'カテゴリ詳細ページからカテゴリの削除ができること' do
      sign_in_as(admin)
      visit categories_path
      expect do
        click_on '削除'
        page.accept_confirm '本当に削除しますか？'
        expect(page).to have_content 'カテゴリーを削除しました'
      end.to change(Category, :count).by(-1)
    end
  end
end
