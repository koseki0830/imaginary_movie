class CommentsController < ApplicationController
  def create
    comment = current_user.comments.new(comment_params)
    if comment.save
      flash[:notice] = t('.success')
      redirect_to movie_reviews_path(comment.review)
    else
      # 画面上部のフラッシュメッセージをスキップしてバリデーションのみ表示する設定
      flash[:skip_flash_message] = true
      # flash[:alert]にエラーメッセージを格納してビューで表示している
      redirect_to movie_reviews_path(comment.review), flash: { alert: comment.errors.full_messages }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(review_id: params[:review_id])
  end
end
