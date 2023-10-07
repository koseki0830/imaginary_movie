class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user_id, uniqueness: { scope: :movie_id }
end
