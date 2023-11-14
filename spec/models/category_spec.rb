require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'アソシエーションに関するテスト' do
    before do
      @category = FactoryBot.create(:category)
      @movie1 = FactoryBot.create(:movie)
      @movie2 = FactoryBot.create(:movie)
      MovieCategory.create(movie: @movie1, category: @category)
      MovieCategory.create(movie: @movie2, category: @category)
    end

    it '複数の映画と関連付けられている' do
      expect(@category.movies).to include(@movie1, @movie2)
    end
  end
end
