class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: user

  validates :contains_spoiler, inclusion: [true, false]
  validates :content, presence: true
 end
