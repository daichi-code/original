require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    it '全ての項目の入力が存在すれば登録できること' do
      expect(@item).to be_valid
    end

    it 'textが空では登録できないこと' do
      @item.text = nil
      @item.valid?
    end

    it 'imageが空では登録できないこと' do
      @item.images = nil
      @item.valid?
    end

    it 'category_idが1では登録できないこと' do
      @item.category_id = 1
      @item.valid?
    end

    it 'prefecture_idが1では登録できないこと' do
      @item.prefecture_id = 1
      @item.valid?
    end

    it 'season_idが1では登録できないこと' do
      @item.season_id = 1
      @item.valid?
    end

    it 'category_idが空では登録できないこと' do
      @item.category_id = nil
      @item.valid?
    end

    it 'prefecture_idが空では登録できないこと' do
      @item.prefecture_id = nil
      @item.valid?
    end

    it 'season_idが空では登録できないこと' do
      @item.season_id = nil
      @item.valid?
    end

    it 'userが紐づいていないと保存できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end
  end
end
