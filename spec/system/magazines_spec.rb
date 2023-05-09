# require 'rails_helper'

# RSpec.describe '/magazines', type: :system do
#   let(:user) { create(:admin) }
#   let(:non_admin) { create(:non_admin) }
#   let!(:magazine) { create(:magazine, user_id: user.id) }

#   describe 'new' do
#     it '管理者以外が記事作成ページに遷移するとリダイレクトされること' do
#       sign_in_as(non_admin, uid: '5678')
#       visit new_magazine_path
#       expect(page).to have_content '管理者としてログインしてください'
#     end
#   end

#   describe 'index' do
#     let!(:yesterday_magazine) { create(:yesterday_magazine, user_id: user.id) }
#     let!(:day_before_yesterday_magazine) { create(:day_before_yesterday_magazine, user_id: user.id) }

#     it '記事が公開日順に並べられていること' do
#       visit magazines_path
#       within '.magazine-tab-container' do
#         post_title = all('.card-header-title').map(&:text)
#         expect(post_title).to eq ['【購入品紹介】"French Navy" Deck Jacket', '公開日が昨日の記事', '公開日が一昨日の記事']
#       end
#     end

#     it '管理者以外は記事作成ボタンが表示されないこと' do
#       sign_in_as(non_admin, uid: '5678')
#       visit magazines_path
#       expect(page).to have_no_content 'New Magazine'
#     end
#   end

#   describe 'create' do
#     it '記事作成画面から記事を作成できること' do
#       sign_in_as(user)
#       visit new_magazine_path
#       expect do
#         expect(page).to have_content 'Magazine作成'
#         fill_in 'magazine_title', with: 'テストタイトル'
#         fill_in 'magazine_publish_at', with: Date.current
#         fill_in_rich_text_area 'magazine_body', with: 'テスト文章'
#         click_on '登録する'
#         expect(page).to have_content '記事を作成しました'
#       end.to change(Magazine, :count).by(1)
#     end
#   end

#   describe 'show' do
#     it '作成した記事詳細ページが存在すること' do
#       visit magazine_path(magazine)
#       expect(page).to have_content '【購入品紹介】"French Navy" Deck Jacket'
#     end

#     it '管理者以外は記事編集と記事削除ボタンが表示されないこと' do
#       sign_in_as(non_admin, uid: '5678')
#       visit magazine_path(magazine)
#       expect(page).to have_no_content '記事編集'
#       expect(page).to have_no_content '記事削除'
#     end
#   end

#   describe 'update' do
#     it '記事詳細ページから記事の編集ができること' do
#       sign_in_as(user)
#       visit magazine_path(magazine)
#       expect do
#         click_on '記事編集'
#         fill_in 'magazine_title', with: '変更タイトル'
#         click_on '更新する'
#         expect(page).to have_content '記事を更新しました'
#       end.to change(Magazine, :count).by(0)
#     end
#   end

#   describe 'destroy' do
#     it '記事詳細ページから記事の削除ができること' do
#       sign_in_as(user)
#       visit magazine_path(magazine)
#       expect do
#         click_on '記事削除'
#         page.accept_confirm '本当に削除しますか？'
#         expect(page).to have_content '記事を削除しました'
#       end.to change(Magazine, :count).by(-1)
#     end
#   end
# end
