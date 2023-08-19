require 'rails_helper'

RSpec.describe '/', type: :system do
  let!(:no_thumbnail_magazine) { create(:no_thumbnail_magazine) }

  it 'サムネイル画像のない記事があってもトップページが表示されること' do
    visit root_path
    expect(page).to have_content 'サムネイル画像がない記事'
  end
end
