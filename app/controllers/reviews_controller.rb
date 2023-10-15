class ReviewsController < ApplicationController
  skip_before_action :require_login, only: %i[show]

  # レビューの新規投稿画面
  def new
    @movie = Movie.find(params[:movie_id])
    @review = Review.new
  end

  # レビューの新規投稿機能
  def create
    @movie = Movie.find(params[:movie_id])
    @review = current_user.reviews.new(review_params)
    if @review.save
      render movie_path(@review.movie)
    else
      render :new
    end
  end

  # 自身の投稿したレビューの編集画面
  def edit
    @movie = Movie.find(params[:movie_id])
    @review = current_user.reviews.find(params[:id])
  end

  # 自身が投稿したレビューの編集機能
  def update
    @review = current_user.reviews.find(params[:id])
    if @review.update(review_params)
      render movie_path(@review.movie)
    else
      render :edit
    end
  end

  # レビューの表示
  def show
    @review = Review.find(params[:id])

    @movie = @review.movie
    @comment = Comment.new
    @comments = @review.comments.includes(:user).order(created_at: :desc)
  end

  # 自身が投稿したレビューの削除
  def destroy
    @review = current_user.reviews.find(params[:id])
    @review.destroy!
    redirect_to movie_path(@review.movie)
  end

  private

  def review_params 
    params.require(:review).permit(:content, :contains_spoiler, :rating).merge(movie_id: params[:movie_id])
  end
end
