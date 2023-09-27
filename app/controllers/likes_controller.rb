class LikesController < ApplicationController
  before_action :set_review, only: %i[create destroy]
  def create
    @like = current_user.likes.new(review_id: @review.id)
    @like.save
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, review_id: @review.id)
    @like.destroy
  end

  private
    def set_review
      @review = Review.find_by(id: params[:review_id])
    end
end
