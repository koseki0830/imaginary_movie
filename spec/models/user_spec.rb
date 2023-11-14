require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:movie) { FactoryBot.create(:movie, user: user) }
  let(:other_movie) { FactoryBot.create(:movie, user: other_user) }
  let(:review) { FactoryBot.create(:review) }

  describe 'バリデーションに関するテスト' do
    it '名前、メールアドレス、パスワードがある場合は有効' do
      valid_user = FactoryBot.build(:user)
      expect(valid_user).to be_valid
    end

    it '名前がない場合は無効' do
      user_without_name = FactoryBot.build(:user, name: '')
      expect(user_without_name).to be_invalid
    end

    it '名前が100文字を超える場合は無効' do
      long_name_user = FactoryBot.build(:user, name: 'a' * 101)
      expect(long_name_user).to be_invalid
    end

    it '重複した名前の場合は無効' do
      user = FactoryBot.create(:user)
      user_duplicate_name = FactoryBot.build(:user, name: user.name)
      expect(user_duplicate_name).to be_invalid
    end

    it 'メールアドレスがない場合は無効' do
      user_without_email = FactoryBot.build(:user, email: '')
      expect(user_without_email).to be_invalid
    end

    it '重複したメールアドレスの場合は無効' do
      user = FactoryBot.create(:user)
      user_duplicate_email = FactoryBot.build(:user, email: user.email)
      expect(user_duplicate_email).to be_invalid
    end

    it 'パスワードがない場合は無効' do
      user_without_password = FactoryBot.build(:user, password: '')
      expect(user_without_password).to be_invalid
    end

    it 'パスワードが3文字未満の場合は無効' do
      user_with_short_password = FactoryBot.build(:user, password: 'ab', password_confirmation: 'ab')
      expect(user_with_short_password).to be_invalid
    end

    it 'パスワード（確認用)とパスワードが一致しない場合は無効' do
      user_password_mismatch = FactoryBot.build(:user, password_confirmation: 'mismatch')
      expect(user_password_mismatch).to be_invalid
    end
  end

  describe 'アソシエーションに関するテスト' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'moviesとの関係性' do
      movie1 = FactoryBot.create(:movie, user: @user)
      movie2 = FactoryBot.create(:movie, user: @user)
      expect(@user.movies).to include(movie1, movie2)
    end

    it 'reviewsとの関係性' do
      review1 = FactoryBot.create(:review, user: @user)
      review2 = FactoryBot.create(:review, user: @user)
      expect(@user.reviews).to include(review1, review2)
    end

    it 'likesとの関係性' do
      review1 = FactoryBot.create(:review)
      review2 = FactoryBot.create(:review)
      like1 = Like.create(review: review1, user: @user)
      like2 = Like.create(review: review2, user: @user)
      expect(@user.likes).to include(like1, like2)
    end

    it 'commentsとの関係性' do
      comment1 = FactoryBot.create(:comment, user: @user)
      comment2 = FactoryBot.create(:comment, user: @user)
      expect(@user.comments).to include(comment1, comment2)
    end

    it 'bookmarksとの関係性' do
      movie1 = FactoryBot.create(:movie)
      movie2 = FactoryBot.create(:movie)
      bookmark1 = Bookmark.create(movie: movie1, user: @user)
      bookmark2 = Bookmark.create(movie: movie2, user: @user)
      expect(@user.bookmarks).to include(bookmark1, bookmark2)
    end
  end

  describe 'カスタムメソッドに関するテスト' do
    context 'own?メソッドについて' do
      it '自分が投稿した映画の場合、trueを返す' do
        expect(user.own?(movie)).to be true
      end

      it '他のユーザーが投稿した映画の場合、falseを返す' do
        expect(user.own?(other_movie)).to be false
      end
    end

    context 'いいね機能' do
      it 'likeメソッドが正しく機能する' do
        user.like(review)
        expect(user.like_reviews).to include(review)
      end

      it 'unlikeメソッドが正しく機能する' do
        user.like(review)
        user.unlike(review)
        expect(user.like_reviews).not_to include(review)
      end

      it 'like?メソッドが正しく機能する' do
        user.like(review)
        expect(user.like?(review)).to be true
      end
    end

    context 'ブックマーク機能' do
      it 'bookmarkメソッドが正しく機能する' do
        user.bookmark(movie)
        expect(user.bookmark_movies).to include(movie)
      end

      it 'unbookmarkメソッドが正しく機能する' do
        user.bookmark(movie)
        user.unbookmark(movie)
        expect(user.bookmark_movies).not_to include(movie)
      end

      it 'bookmark?メソッドが正しく機能する' do
        user.bookmark(movie)
        expect(user.bookmark?(movie)).to be true
      end
    end

    context 'ブックマーク数の合計' do
      it 'total_bookmarks_countメソッドが正しくブックマーク数を返す' do
        another_user1 = FactoryBot.create(:user)
        another_user2 = FactoryBot.create(:user)
        movie1 = FactoryBot.create(:movie, user: user)
        movie2 = FactoryBot.create(:movie, user: user)
        another_user1.bookmark(movie1)
        another_user2.bookmark(movie2)
        expect(user.total_bookmarks_count).to eq(2)
      end
    end
  end
end
