class Movie < ApplicationRecord
  attr_accessor :thumbnail_cache
  mount_uploader :thumbnail, ThumbnailUploader
  belongs_to :user

  validates :title, presence: true
  validates :title, length: { maximum: 100 }
  validates :synopsis, presence: true
  validates :synopsis, length: { maximum: 500 }
  validates :screening_time, presence: true
  validates :screening_time, length: { maximum: 1000 }
end
