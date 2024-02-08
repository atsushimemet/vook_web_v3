require 'rails_helper'

RSpec.describe Magazine, type: :model do
  describe 'ステータス判定メソッド' do
    let!(:draft_magazine) { build(:draft) }
    let!(:published_magazine) { build(:yesterday_magazine) }
    let!(:scheduled_magazine) { build(:scheduled) }

    describe '#draft?' do
      it '下書きの場合はtrueを返す' do
        expect(draft_magazine).to be_draft
      end

      it '公開済みまたは予約投稿の場合はfalseを返す' do
        expect(published_magazine).not_to be_draft
        expect(scheduled_magazine).not_to be_draft
      end
    end

    describe '#published?' do
      it '公開済みの場合はtrueを返す' do
        expect(published_magazine).to be_published
      end

      it '下書きまたは予約投稿の場合はfalseを返す' do
        expect(draft_magazine).not_to be_published
        expect(scheduled_magazine).not_to be_published
      end
    end

    describe '#scheduled?' do
      it '予約投稿の場合はtrueを返す' do
        expect(scheduled_magazine).to be_scheduled
      end

      it '下書きまたは公開済みの場合はfalseを返す' do
        expect(draft_magazine).not_to be_scheduled
        expect(published_magazine).not_to be_scheduled
      end
    end
  end
end
