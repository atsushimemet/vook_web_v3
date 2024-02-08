require 'rails_helper'

RSpec.describe '/knowledges', type: :system do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let!(:knowledge) { create(:knowledge, user: admin) }

  describe 'new' do
    it '管理者以外が知識作成ページに遷移するとリダイレクトされること' do
      sign_in_as(user)
      visit new_knowledge_path
      expect(page).to have_content '管理者としてログインしてください'
    end
  end

  describe 'create' do
    before do
      sign_in_as(admin)
      visit new_knowledge_path
    end

    it '管理者が知識作成ページから知識記事を作成できること' do
      expect do
        expect(page).to have_content 'Knowledge作成'
        attach_file 'knowledge_image', Rails.root.join('public/test.png'), visible: false
        fill_in 'knowledge_name', with: 'テストタイトル'
        select "Levi's", from: 'knowledge_brand_id'
        select '501', from: 'knowledge_line_id'
        fill_in 'knowledge_age', with: '1980'
        fill_in_rich_text_area 'knowledge_body', with: 'テスト文章'
        click_on '登録'
        expect(page).to have_content 'ページを作成しました'
        expect(page).to have_content 'Denim Pants'
      end.to change(Knowledge, :count).by(1)
    end

    it '空欄投稿では知識記事が作成できないこと' do
      expect do
        click_on '登録'
        expect(page).to have_content '投稿に失敗しました'
        expect(page).to have_content '名前を入力してください'
      end.to change(Knowledge, :count).by(0)
    end
  end

  describe 'show' do
    it 'トップページのブランドタブから知識詳細ページへ遷移できること' do
      visit root_path
      click_on "Levi's"
      expect(page).to have_content "Levi's"
      click_on '501'
      expect(page).to have_content '501'
      click_on '66前期'
      expect(page).to have_content 'フロントボタン'
    end

    it 'トップページのアイテムタブから知識詳細ページへ遷移できること' do
      visit root_path
      click_on 'Denim Pants'
      expect(page).to have_content 'Denim Pants'
      click_on '501'
      expect(page).to have_content '501'
      click_on '66前期'
      expect(page).to have_content 'フロントボタン'
    end

    it 'イメージ画像のない知識詳細ページへ遷移できること' do
      create(:no_image_knowledge, user: admin)
      visit root_path
      click_on 'Denim Pants'
      expect(page).to have_content 'Denim Pants'
      click_on '501'
      expect(page).to have_content '501'
      click_on 'イメージ画像がない知識', match: :first
      expect(page).to have_content 'この知識にはイメージがありません'
    end

    it '管理者以外は編集と削除ボタンが表示されないこと' do
      sign_in_as(user)
      visit knowledge_path(knowledge)
      expect(page).to have_no_content '編集'
      expect(page).to have_no_content '削除'
    end
  end

  describe 'update' do
    before do
      sign_in_as(admin)
      visit knowledge_path(knowledge)
    end

    it '知識詳細ページから知識記事の編集ができること' do
      expect do
        click_on '編集'
        fill_in 'knowledge_name', with: '変更タイトル'
        click_on '更新'
        expect(page).to have_content 'ページを更新しました'
      end.to change(Knowledge, :count).by(0)
    end

    it '空欄投稿では記事の編集ができないこと' do
      expect do
        click_on '編集'
        fill_in 'knowledge_name', with: ''
        click_on '更新'
        expect(page).to have_content '更新に失敗しました'
        expect(page).to have_content '名前を入力してください'
      end.to change(Knowledge, :count).by(0)
    end
  end

  describe 'destroy' do
    it '知識詳細ページから知識記事の削除ができること' do
      sign_in_as(admin)
      visit knowledge_path(knowledge)
      expect do
        click_on '削除'
        page.accept_confirm '本当に削除しますか？'
        expect(page).to have_content 'ページを削除しました'
      end.to change(Knowledge, :count).by(-1)
    end
  end
end
