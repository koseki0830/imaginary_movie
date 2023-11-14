require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'バリデーションに関するテスト' do
    it '全ての項目を満たしている時は有効' do
      valid_movie = FactoryBot.build(:movie)
      expect(valid_movie).to be_valid
    end

    it 'タイトルがない場合は無効' do
      movie_without_title = FactoryBot.build(:movie, title: '')
      expect(movie_without_title).to be_invalid
    end

    it 'タイトルの長さが100文字を超える場合は無効' do
      long_title_movie = FactoryBot.build(:movie, title: 'a' * 101)
      expect(long_title_movie).to be_invalid
    end

    it '上映時間がない場合は無効' do
      movie_without_screening_time = FactoryBot.build(:movie, screening_time: '')
      expect(movie_without_screening_time).to be_invalid
    end

    it '上映時間が1000分を超える場合は無効' do
      long_screening_time_movie = FactoryBot.build(:movie, screening_time: 1001)
      expect(long_screening_time_movie).to be_invalid
    end

    it '上映時間が1分より短い場合は無効' do
      short_screening_time_movie = FactoryBot.build(:movie, screening_time: 0)
      expect(short_screening_time_movie).to be_invalid
    end

    it 'カテゴリー選択がない場合は無効' do
      movie_without_category = FactoryBot.build(:movie)
      movie_without_category.categories.clear
      expect(movie_without_category).to be_invalid
    end

    it 'あらすじがない場合は無効' do
      movie_without_synopsis = FactoryBot.build(:movie, synopsis: '')
      expect(movie_without_synopsis).to be_invalid
    end

    it 'あらすじが500文字を超える場合は無効' do
      long_synopsis_movie = FactoryBot.build(:movie, synopsis: 'a' * 501)
      expect(long_synopsis_movie).to be_invalid
    end

    it 'ポスター画像がない場合は無効' do
      movie_without_thumbnail = FactoryBot.build(:movie, thumbnail: '')
      expect(movie_without_thumbnail).to be_invalid
    end

    it 'ポスター画像のテキストの色の入力がない場合は無効' do
      movie_without_text_color = FactoryBot.build(:movie, text_color: '')
      expect(movie_without_text_color).to be_invalid
    end

    it 'ポスター画像のテキストの大きさの入力がない場合は無効' do
      movie_without_text_size = FactoryBot.build(:movie, text_size: '')
      expect(movie_without_text_size).to be_invalid
    end

    it 'ポスター画像のテキストの位置の入力がない場合は無効' do
      movie_without_text_position = FactoryBot.build(:movie, text_position: '')
      expect(movie_without_text_position).to be_invalid
    end
  end

  describe 'アソシエーションに関するテスト' do
   before do
    @movie = FactoryBot.create(:movie)
   end

   it 'userとの関係性' do
    expect(@movie.user).to be_present
   end

   it 'categoriesとの関係性' do
    category = FactoryBot.create(:category)
    @movie.categories << category
    expect(@movie.categories).to include(category)
   end

   it 'reviewsとの関係性' do
    review1 = FactoryBot.create(:review, movie: @movie)
    review2 = FactoryBot.create(:review, movie: @movie)
    expect(@movie.reviews).to include(review1, review2)
   end

   it 'bookmarksとの関係性' do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    bookmark1 = Bookmark.create(user: user1, movie: @movie)
    bookmark2 = Bookmark.create(user: user2, movie: @movie)

    expect(@movie.bookmarks).to include(bookmark1, bookmark2)
    expect(@movie.bookmark_users).to include(user1, user2)
   end
  end
end
