require 'rails_helper'

RSpec.describe '/magazines', type: :system do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let!(:magazine) { create(:magazine) }

  describe 'new' do
    it '管理者以外が記事作成ページに遷移するとリダイレクトされること' do
      sign_in_as(user)
      visit new_magazine_path
      expect(page).to have_content '管理者としてログインしてください'
    end
  end

  describe 'index' do
    let!(:yesterday_magazine) { create(:yesterday_magazine) }
    let!(:day_before_yesterday_magazine) { create(:day_before_yesterday_magazine) }

    it '記事が公開日順に並べられていること' do
      visit magazines_path
      expect(page).to have_selector('.magazine-card-header')
      within '.magazine-cards' do
        post_title = all('.magazine-card-header').map(&:text)
        expect(post_title).to eq ['【購入品紹介】"French Navy" Deck Jacket', '公開日が昨日の記事', '公開日が一昨日の記事']
      end
    end

    it '管理者以外は記事作成ボタンが表示されないこと' do
      sign_in_as(user)
      visit magazines_path
      expect(page).to have_selector('.magazine-card-header')
      expect(page).to have_no_content 'New Magazine'
    end

    context '下書きの記事があるとき' do
      let!(:draft) { create(:draft) }

      it '管理者は表示される' do
        sign_in_as(admin)
        visit magazines_path
        expect(page).to have_selector('.magazine-card-header')
        expect(page).to have_content '下書き'
      end

      it '管理者以外は表示されないこと' do
        visit magazines_path
        expect(page).to have_selector('.magazine-card-header')
        expect(page).to have_no_content '下書き'
      end
    end

    context '予定投稿の記事があるとき' do
      let!(:scheduled) { create(:scheduled) }

      it '管理者は表示される' do
        sign_in_as(admin)
        visit magazines_path
        expect(page).to have_selector('.magazine-card-header')
        expect(page).to have_content '予約投稿'
      end

      it '管理者以外は表示されないこと' do
        visit magazines_path
        expect(page).to have_selector('.magazine-card-header')
        expect(page).to have_no_content '予約投稿'
      end
    end
  end

  describe 'create' do
    before do
      sign_in_as(admin)
      visit new_magazine_path
    end

    it '記事作成画面から記事を作成できること' do
      expect do
        expect(page).to have_content 'Magazine作成'
        fill_in 'magazine_title', with: 'テストタイトル'
        fill_in 'magazine_publish_at', with: Time.current
        fill_in_rich_text_area 'magazine_body', with: 'テスト文章'
        click_on '登録'
        expect(page).to have_content '記事を作成しました'
      end.to change(Magazine, :count).by(1)
    end

    it '空欄投稿時にエラーメッセージが表示されること' do
      expect do
        expect(page).to have_content 'Magazine作成'
        click_on '登録'
        expect(page).to have_content '投稿に失敗しました'
        expect(page).to have_content 'タイトルを入力してください'
      end.not_to change(Magazine, :count)
    end
  end

  describe 'show' do
    it '作成した記事詳細ページが存在すること' do
      visit magazine_path(magazine)
      expect(page).to have_content '【購入品紹介】"French Navy" Deck Jacket'
    end

    it '管理者以外は編集と削除ボタンが表示されないこと' do
      sign_in_as(user)
      visit magazine_path(magazine)
      expect(page).to have_no_content '編集'
      expect(page).to have_no_content '削除'
    end

    context '下書きの記事があるとき' do
      let!(:draft) { create(:draft) }

      it '管理者は表示される' do
        sign_in_as(admin)
        visit magazine_path(draft)
        expect(page).to have_content '下書き'
      end

      it '管理者以外は404ページへ遷移すること' do
        visit magazine_path(draft)
        expect(page).to have_content '404'
        expect(page).to have_no_content '下書き'
      end
    end

    context '予定投稿の記事があるとき' do
      let(:scheduled) { create(:scheduled) }

      it '管理者は表示される' do
        sign_in_as(admin)
        visit magazine_path(scheduled)
        expect(page).to have_content '予約投稿'
      end

      it '管理者以外は404ページへ遷移すること' do
        visit magazine_path(scheduled)
        expect(page).to have_content '404'
        expect(page).to have_no_content '予約投稿'
      end
    end
  end

  describe 'update' do
    context '管理者の場合' do
      before do
        sign_in_as(admin)
        visit magazine_path(magazine)
      end

      it '記事詳細ページから記事の編集ができること' do
        expect do
          click_on '編集'
          fill_in 'magazine_title', with: '変更タイトル'
          click_on '更新'
          expect(page).to have_content '記事を更新しました'
        end.not_to change(Magazine, :count)
      end

      it '空欄投稿では記事の編集ができないこと' do
        expect do
          click_on '編集'
          fill_in 'magazine_title', with: ''
          click_on '更新'
          expect(page).to have_content '更新に失敗しました'
          expect(page).to have_content 'タイトルを入力してください'
        end.not_to change(Magazine, :count)
      end
    end

    context '管理者以外の場合' do
      it 'ページ遷移しようとするとリダイレクトされること' do
        sign_in_as(user)
        visit edit_magazine_path(magazine)
        expect(page).to have_content '管理者としてログインしてください'
      end
    end
  end

  describe 'destroy' do
    it '記事詳細ページから記事の削除ができること' do
      sign_in_as(admin)
      visit magazine_path(magazine)
      expect do
        click_on '削除'
        page.accept_confirm '本当に削除しますか？'
        expect(page).to have_content '記事を削除しました'
      end.to change(Magazine, :count).by(-1)
    end
  end
end
