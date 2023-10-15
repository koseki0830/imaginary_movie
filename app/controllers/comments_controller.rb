class CommentsController < ApplicationController
  def create
    comment = current_user.comments.new(comment_params)
    if comment.save
      flash[:notice] = "コメントを投稿しました"
      redirect_to movie_reviews_path(comment.review)
    else
      redirect_to movie_reviews_path(comment.review)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(review_id: params[:review_id])
  end
end
