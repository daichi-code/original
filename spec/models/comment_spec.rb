require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#create' do
    before do
      @comment = FactoryBot.build(:comment)
    end

    it 'textが存在していれば保存できること' do
      expect(@comment).to be_valid
    end

    it 'textが存在していなければ保存できないこと' do
      @comment.text = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Text can't be blank")
    end
  end
end
