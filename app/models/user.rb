# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :movies, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_reviews, through: :likes, source: :review
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_movies, through: :bookmarks, source: :movie

  validates :name, presence: true
  validates :name, length: { maximum: 100 }
  validates :name, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  def own?(object)
    id == object.user_id
  end

  # レビューのいいね機能
  def like(review)
    like_reviews << review
  end

  def unlike(review)
    like_reviews.destroy(review)
  end

  def like?(review)
    like_reviews.include?(review)
  end

  # 映画のお気に入り機能
  def bookmark(movie)
    bookmark_movies << movie
  end

  def unbookmark(movie)
    bookmark_movies.destroy(movie)
  end

  def bookmark?(movie)
    bookmark_movies.include?(movie)
  end

  # ユーザーごとに関連する映画のブックマーク数合計を出す
  def total_bookmarks_count
    movies.joins(:bookmarks).count
  end

  def top_categories_movies
    # ユーザーが投稿した映画とお気に入りした映画のカテゴリーを集計し、トップ3カテゴリーを取得
    user_posted_categories = movies.flat_map(&:categories)
    user_bookmarked_categories = bookmark_movies.flat_map(&:categories)

    category_count = (user_posted_categories + user_bookmarked_categories).group_by(&:itself).transform_values(&:count)
    top_categories = category_count.sort_by { |_, count| -count }.take(3).to_h.keys
    
    # トップ3カテゴリーのそれぞれブックマーク数が一番多い映画を取得
    top_categories.map do |category|
      Movie.joins(:categories, :bookmarks)
           .where(categories: { name: category.name })
           .left_joins(:bookmarks)
           .group('movies.id')
           .order('COUNT(bookmarks.id) DESC NULLS LAST')
           .includes(:user)
           .first
    end.compact
  end
end
