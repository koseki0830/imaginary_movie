class Movie < ApplicationRecord
  attr_accessor :thumbnail_cache
  mount_uploader :thumbnail, ThumbnailUploader
  belongs_to :user
  has_many :movie_categories, dependent: :destroy
  has_many :categories, through: :movie_categories
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_users, through: :bookmarks, source: :user

  validates :title, presence: true
  validates :title, length: { maximum: 100 }
  validates :screening_time, presence: true
  validates :screening_time, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000  }
  validates :category_ids, presence: true
  validates :synopsis, presence: true
  validates :synopsis, length: { maximum: 500 }

  # サムネイルのテキストについてのバリデーション
  validates :text_position, inclusion: { in: %w[south center north] }
  validates :text_color, presence: true
  validates :text_size, numericality: { only_integer: true, greater_than: 9, less_than: 200 }
  validates :font_type, presence: true

end