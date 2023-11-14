require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'バリデーションに関するテスト' do
    let(:user) { FactoryBot.create(:user) }
    let(:movie) { FactoryBot.create(:movie) }
    let(:bookmark) { FactoryBot.create(:bookmark, user: user, movie: movie) }

    it 'ユーザーと映画があれば有効' do
      expect(bookmark).to be_valid
    end

    it '同じユーザーが同じ映画に複数回ブックマークできない' do
      bookmark
      duplicate_bookmark = Bookmark.new(user: user, movie: movie)
      duplicate_bookmark.valid?
      expect(duplicate_bookmark.errors[:user_id]).to include('はすでに存在します')
    end
  end

  describe 'アソシエーションに関するテスト' do
    it 'userとの関係性' do
      bookmark = FactoryBot.create(:bookmark)
      expect(bookmark.user).to be_present
    end

    it 'movieとの関係性' do
      bookmark = FactoryBot.create(:bookmark)
      expect(bookmark.movie).to be_present
    end
  end  
end
