# require 'rails_helper'

# RSpec.describe '/knowledges', type: :system do
#   let(:user) { create(:admin) }
#   let(:non_admin) { create(:non_admin) }
#   let(:brand) { create(:brand) }
#   let(:item) { create(:item) }
#   let(:line) { create(:line, brand_id: brand.id, item_id: item.id) }
#   let!(:knowledge) { create(:knowledge, user_id: user.id, brand_id: brand.id, item_id: item.id, line_id: line.id) }

#   describe 'new' do
#     it '管理者以外が知識作成ページに遷移するとリダイレクトされること' do
#       sign_in_as(non_admin, uid: '5678')
#       visit new_knowledge_path
#       expect(page).to have_content '管理者としてログインしてください'
#     end
#   end

#   describe 'create' do
#     it '管理者が知識作成ページから知識記事を作成できること' do
#       sign_in_as(user)
#       visit new_knowledge_path
#       expect do
#         expect(page).to have_content 'Knowledge作成'
#         # attach_file 'Image', Rails.root.join('app', 'assets', 'images', 'knowledge-501xx1.jpg')
#         fill_in 'knowledge_name', with: 'テストタイトル'
#         select "Levi's", from: 'knowledge_brand_id'
#         select 'Denim', from: 'knowledge_item_id'
#         select '501XX', from: 'knowledge_line_id'
#         fill_in 'knowledge_age', with: '1980'
#         fill_in_rich_text_area 'knowledge_body', with: 'テスト文章'
#         click_on '登録する'
#         expect(page).to have_content 'ページを作成しました'
#       end.to change(Knowledge, :count).by(1)
#     end
#   end

#   describe 'show' do
#     it 'トップページのブランドタブから知識詳細ページへ遷移できること' do
#       visit root_path
#       find('a', text: 'BLAND').click
#       click_on "Levi's"
#       expect(page).to have_content "Levi's"
#       click_on '501XX'
#       expect(page).to have_content '501XX'
#       click_on 'ギャラ入り'
#       expect(page).to have_content '紙パッチ'
#     end

#     it 'トップページのアイテムタブから知識詳細ページへ遷移できること' do
#       visit root_path
#       find('a', text: 'ITEM').click
#       click_on 'Denim'
#       expect(page).to have_content 'Denim'
#       click_on '501XX'
#       expect(page).to have_content '501XX'
#       click_on 'ギャラ入り'
#       expect(page).to have_content '紙パッチ'
#     end

#     it '管理者以外は記事編集と記事削除ボタンが表示されないこと' do
#       sign_in_as(non_admin, uid: '5678')
#       visit knowledge_path(knowledge)
#       expect(page).to have_no_content '記事編集'
#       expect(page).to have_no_content '記事削除'
#     end
#   end

#   describe 'update' do
#     it '知識詳細ページから知識記事の編集ができること' do
#       sign_in_as(user)
#       visit knowledge_path(knowledge)
#       expect do
#         click_on '記事編集'
#         fill_in 'knowledge_name', with: '変更タイトル'
#         click_on '更新する'
#         expect(page).to have_content 'ページを更新しました'
#       end.to change(Knowledge, :count).by(0)
#     end
#   end

#   describe 'destroy' do
#     it '知識詳細ページから知識記事の削除ができること' do
#       sign_in_as(user)
#       visit knowledge_path(knowledge)
#       expect do
#         click_on '記事削除'
#         page.accept_confirm '本当に削除しますか？'
#         expect(page).to have_content 'ページを削除しました'
#       end.to change(Knowledge, :count).by(-1)
#     end
#   end
# end
