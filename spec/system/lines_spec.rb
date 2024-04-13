require 'rails_helper'

RSpec.describe '/lines', type: :system do
  let!(:line) { create(:line) }
  let(:admin) { create(:admin) }

  describe 'show' do
    context '公開された知識が存在する場合' do
      let!(:knowledge) { create(:knowledge, line:, status: :published) }

      it 'ラインの詳細ページを表示する' do
        visit line_path(line.name)
        expect(page).to have_content knowledge.name
      end
    end

    context '公開された知識が存在しない場合' do
      let!(:knowledge) { create(:knowledge, line:, status: :draft) }

      it '非管理者はルートページにリダイレクトされる' do
        visit line_path(line.name)
        expect(page).to have_current_path root_path
        expect(page).to have_content 'コンテンツが存在しません'
      end

      it '管理者はラインの詳細ページを表示できる' do
        sign_in_as(admin)
        visit line_path(line.name)
        expect(page).to have_content line.name
      end
    end
  end
end
