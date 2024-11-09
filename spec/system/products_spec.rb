require 'rails_helper'

RSpec.describe 'Products', type: :system do
  let!(:product) { create(:product) }
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  describe 'show' do
    context '商品が存在する場合' do
      before do
        create(:product2, knowledge: product.knowledge)
      end

      it '商品ページが存在すること' do
        visit product_path(knowledge_id: product.knowledge.id)
        expect(page).to have_content "リーバイス 501 ネイビー LEVI'S 66前期 BIGE 初期 w28 001"
      end

      # it 'サイズボタンを押すとサイズに紐づいた商品が表示されること' do
      #   visit product_path(knowledge_id: product.knowledge.id)
      #   click_on 'w32'
      #   expect(page).to have_content "リーバイス 501 ネイビー LEVI'S 66前期 BIGE 初期 w32 002"
      #   expect(page).not_to have_content "リーバイス 501 ネイビー LEVI'S 66前期 BIGE 初期 w28 001"
      # end
    end

    context '商品が存在しない場合' do
      before do
        product.knowledge.products.delete_all
      end

      it 'トップページにリダイレクトされること' do
        sign_in_as(user)
        visit product_path(knowledge_id: product.knowledge.id)
        expect(page).to have_current_path root_path
        expect(page).to have_content 'コンテンツが存在しません'
      end

      it '管理者ではページが表示されること' do
        sign_in_as(admin)
        visit product_path(knowledge_id: product.knowledge.id)
        expect(page).to have_current_path product_path(knowledge_id: product.knowledge.id), ignore_query: true
        expect(page).to have_content '現在、商品情報はありません'
      end
    end
  end
end
