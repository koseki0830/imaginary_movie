class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :contains_spoiler, inclusion: [true, false]
 end
