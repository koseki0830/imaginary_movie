require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーションに関するテスト' do
    it '全ての項目を満たしている場合は有効' do
      valid_comment = FactoryBot.build(:comment)
      expect(valid_comment).to be_valid
    end

    it '本文がない場合は無効' do
      comment_without_content = FactoryBot.build(:comment, content: '')
      expect(comment_without_content).to be_invalid
    end

    it '本文が140文字を超えると無効' do
      long_content_comment = FactoryBot.build(:comment, content: 'a' * 141)
      expect(long_content_comment).to be_invalid
    end
  end

  describe 'アソシエーションに関するテスト' do
    before do
      @comment = FactoryBot.create(:comment)
    end
    
    it 'userとの関係性' do
      expect(@comment.user).to be_present
    end

    it 'reviewとの関係性' do
      expect(@comment.review).to be_present
    end
  end
end
