class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :movies, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_reviews, through: :likes, source: :review
  has_many :commetns, dependent: :destroy


  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  def own?(object)
    id == object.user_id
  end
  
  def like(review)
    like_reviews << review
  end
  
  def unlike(review)
    like_reviews.destroy(review)
  end
  
  def like?(review)
    like_reviews.include?(review)
  end
end
