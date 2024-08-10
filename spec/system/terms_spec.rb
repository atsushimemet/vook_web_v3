require 'rails_helper'

RSpec.describe 'Terms', type: :system do
  let(:admin) { create(:admin) }
  let!(:term) { create(:term) }

  describe 'index' do
    it '用語と説明が表示されること' do
      visit terms_path
      expect(page).to have_content '赤耳'
      expect(page).to have_content 'サイドシームを折り返した際の赤いステッチのこと'
    end
  end

  describe 'new' do
    context '管理者以外の場合' do
      it 'ページ遷移しようとするとリダイレクトされること' do
        visit new_term_path
        expect(page).to have_content '管理者としてログインしてください'
      end
    end
  end

  describe 'create' do
    before do
      sign_in_as(admin)
      visit new_term_path
    end

    it '登録画面から用語を登録できること' do
      expect(page).to have_content '用語登録'
      expect do
        fill_in 'term_name', with: 'テスト'
        fill_in 'term_kana', with: 'テスト'
        fill_in_rich_text_area 'term_description', with: 'テスト文章'
        click_on '登録'
        expect(page).to have_content '用語を登録しました'
      end.to change(Term, :count).by(1)
    end

    it '空欄投稿時にエラーメッセージが表示されること' do
      expect(page).to have_content '用語登録'
      expect do
        click_on '登録'
        expect(page).to have_content '登録に失敗しました'
        expect(page).to have_content '名前を入力してください'
        expect(page).to have_content 'フリガナを入力してください'
      end.not_to change(Term, :count)
    end
  end

  describe 'update' do
    context '管理者の場合' do
      before do
        sign_in_as(admin)
        visit terms_path
      end

      it '一覧ページから用語の編集ができること' do
        click_on '編集'
        expect(page).to have_content '用語編集'
        expect do
          fill_in 'term_name', with: '変更タイトル'
          click_on '更新'
          expect(page).to have_content '用語を更新しました'
        end.not_to change(Term, :count)
      end

      it '空欄投稿では用語の編集ができないこと' do
        click_on '編集'
        expect do
          fill_in 'term_name', with: ''
          click_on '更新'
          expect(page).to have_content '更新に失敗しました'
          expect(page).to have_content '名前を入力してください'
        end.not_to change(Term, :count)
      end

      it '画像の削除ができること' do
        term_with_image = create(:image_term)
        visit terms_path
        expect(page).to have_selector("img[src$='test.png']")
        visit edit_term_path(term_with_image)
        expect(page).to have_content 'test.png'
        check '画像を削除'
        click_on '更新'
        expect(page).to have_content '用語を更新しました'
        expect(page).not_to have_selector("img[src$='test.png']")
      end
    end

    context '管理者以外の場合' do
      it 'ページ遷移しようとするとリダイレクトされること' do
        visit edit_term_path(term)
        expect(page).to have_content '管理者としてログインしてください'
      end
    end
  end

  describe 'destroy' do
    it '用語編集ページから用語の削除ができること' do
      sign_in_as(admin)
      visit edit_term_path(term)
      expect do
        click_on '削除'
        page.accept_confirm '本当に削除しますか？'
        expect(page).to have_content '用語を削除しました'
      end.to change(Term, :count).by(-1)
    end
  end
end
