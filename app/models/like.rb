class Like < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :review, class_name: 'Review', foreign_key: 'review_id'

  validates :user_id, uniqueness: { scope: :review_id }
end
