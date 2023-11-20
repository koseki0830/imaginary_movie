require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  let(:movie) { FactoryBot.create(:movie) }
  let(:user) { FactoryBot.create(:user) }
  let!(:not_spoiler_review) { FactoryBot.create(:review, contains_spoiler: false, movie: movie, user: user) }
  let!(:spoiler_review) { FactoryBot.create(:review, contains_spoiler: true, movie: movie, user: user) }

  describe 'レビュー一覧画面' do
    it 'ネタバレなしのレビューが正しく表示される' do
      visit movie_path(movie)
      expect(page).to have_content(not_spoiler_review.user.name)
      expect(page).to have_content(not_spoiler_review.created_at.strftime("%Y/%m/%d"))
      expect(page).to have_content(not_spoiler_review.content)
      expect(page).to have_content(not_spoiler_review.likes.count)
      expect(page).to have_content(not_spoiler_review.comment_count)
    end

    it 'ネタバレありのレビューの場合はネタバレの注意が表示される' do
      visit movie_path(movie)
      expect(page).to have_content(spoiler_review.user.name)
      expect(page).to have_content(spoiler_review.created_at.strftime("%Y/%m/%d"))
      expect(page).to have_content('※このレビューはネタバレを含みます')
      expect(page).to have_content(spoiler_review.likes.count)
      expect(page).to have_content(spoiler_review.comment_count)
    end
  end

  describe 'レビュー詳細の表示' do
    it 'レビュー詳細画面が正しく表示される' do
      visit movie_path(movie)
      visit movie_review_path(movie, not_spoiler_review)
      expect(page).to have_content(not_spoiler_review.user.name)
      expect(page).to have_content(not_spoiler_review.content)
      expect(page).to have_content(not_spoiler_review.likes.count)
      expect(page).to have_content(not_spoiler_review.comment_count)
    end
  end
end
