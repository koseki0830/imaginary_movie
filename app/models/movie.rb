# frozen_string_literal: true

class Movie < ApplicationRecord
  attr_accessor :thumbnail_cache

  mount_uploader :thumbnail, ThumbnailUploader

  def self.ransackable_attributes(_auth_object = nil)
    %w[title synopsis]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[bookmark_users bookmarks categories movie_categories reviews user]
  end

  def self.top_movies(category)
    joins(:categories, :bookmarks)
      .where(categories: { name: category.name })
      .left_joins(:bookmarks)
      .group('movies.id')
      .order('COUNT(bookmarks.id) DESC NULLS LAST')
      .includes(:user)
      .first
  end

  belongs_to :user
  has_many :movie_categories, dependent: :destroy
  has_many :categories, through: :movie_categories
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_users, through: :bookmarks, source: :user

  validates :title, presence: true
  validates :title, length: { maximum: 100 }
  validates :screening_time, presence: true
  validates :screening_time,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
  validates :categories, presence: true
  validates :synopsis, presence: true
  validates :synopsis, length: { maximum: 500 }
  validates :thumbnail, presence: true

  # サムネイルのテキストについてのバリデーション
  validates :text_color, presence: true
  validates :text_size, presence: true
  validates :text_position, presence: true
end
