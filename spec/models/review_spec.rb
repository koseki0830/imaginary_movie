require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'バリデーションに関するテスト' do
    it '全ての項目を満たしている時は有効' do
      valid_review = FactoryBot.build(:review)
      expect(valid_review).to be_valid
    end

    it 'ネタバレを含むか否かのチェックボックスがnilの場合無効' do
      contains_spoiler_nil_review = FactoryBot.build(:review, contains_spoiler: nil)
      expect(contains_spoiler_nil_review).to be_invalid
    end

    it '本文がない場合は無効' do
      review_without_content = FactoryBot.build(:review, content: '')
      expect(review_without_content).to be_invalid
    end

    it '本文が140文字を超える時無効' do
      long_content_review = FactoryBot.build(:review, content: 'a' * 141)
      expect(long_content_review).to be_invalid
    end

    it 'レーティングがない場合は無効' do
      review_without_rating = FactoryBot.build(:review, rating: '')
      expect(review_without_rating).to be_invalid
    end

    it 'レーティングが1未満の時無効' do
      review_less_than_1_rating = FactoryBot.build(:review, rating: 0)
      expect(review_less_than_1_rating).to be_invalid
    end

    it 'レーティングが5より大きい場合無効' do
      review_over_5_rating = FactoryBot.build(:review, rating: 6)
      expect(review_over_5_rating).to be_invalid
    end
  end

  describe 'アソシエーションに関するテスト' do
    it 'movieとの関係性' do
      movie = FactoryBot.build(:movie)
      review = FactoryBot.build(:review, movie: movie)
      expect(review.movie).to eq(movie)
    end

    it 'userとの関係性' do
      user = FactoryBot.build(:user)
      review = FactoryBot.build(:review, user: user)
      expect(review.user).to eq(user)
    end

    it 'likesとの関係性' do
      review = FactoryBot.build(:review)
      user1 = FactoryBot.build(:user)
      user2 = FactoryBot.build(:user)
      Like.create(review: review, user: user1)
      Like.create(review: review, user: user2)
      expect(review.likes.length).to eq(2)
      expect(review.like_users).to include(user1, user2)
    end

    it 'commentsとの関係性' do
      review = FactoryBot.create(:review)
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      FactoryBot.create(:comment, review: review, user: user1)
      FactoryBot.create(:comment, review: review, user: user2)
      expect(review.comments.length).to eq(2)
    end
  end  
  
  describe 'comments_countメソッドに関するテスト' do
    it '正しいコメント数を表示する' do
      review = FactoryBot.create(:review)
      FactoryBot.create(:comment, review: review)
      FactoryBot.create(:comment, review: review)
      expect(review.comment_count).to eq(2)
    end
  end
end
