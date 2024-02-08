require 'rails_helper'

RSpec.describe 'Products', type: :system do
  let!(:product) { create(:product) }

  describe 'show' do
    before do
      create(:product2, knowledge: product.knowledge)
    end

    it '商品ページが存在すること' do
      visit product_path(knowledge_id: product.knowledge.id)
      expect(page).to have_content 'ALL'
      expect(page).to have_content "リーバイス 501 ネイビー LEVI'S 66前期 BIGE 初期 w28 001"
    end

    it 'サイズボタンを押すとサイズに紐づいた商品が表示されること' do
      visit product_path(knowledge_id: product.knowledge.id)
      click_on 'w32'
      expect(page).to have_content "リーバイス 501 ネイビー LEVI'S 66前期 BIGE 初期 w32 002"
      expect(page).not_to have_content "リーバイス 501 ネイビー LEVI'S 66前期 BIGE 初期 w28 001"
    end
  end
end
