# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  validates :contains_spoiler, inclusion: [true, false]
  validates :content, presence: true
  validates :content, length: { maximum: 140 }
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  def comment_count
    comments.count
  end
end
