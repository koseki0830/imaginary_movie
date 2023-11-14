require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'バリデーションに関するテスト' do
    it 'ユーザーとレビューの組み合わせはユニークであるべき' do
      user = FactoryBot.create(:user)
      review = FactoryBot.create(:review)
      first_like = Like.create(user: user, review: review)
      duplicate_like = Like.new(user: user, review: review)
      expect(duplicate_like).not_to be_valid
    end
  end

  describe 'アソシエーションに関するテスト' do
    before do
      @like = FactoryBot.create(:like)
    end

    it 'userとの関係性' do
      expect(@like.user).to be_present
    end

    it 'reviewとの関係性' do
      expect(@like.review).to be_present
    end
  end
end
