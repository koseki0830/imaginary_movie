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
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

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
end
