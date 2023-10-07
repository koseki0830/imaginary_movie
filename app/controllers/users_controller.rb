class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path # ユーザー作成後にログインするよう変更予定
    else
      render :new
    end
  end

  def show
    # マイページホームのサイドバーに、ブックマーク・レビューした映画数を表示するため変数を定義
    @bookmarks_movies = current_user.bookmark_movies.includes(:user).order(created_at: :desc)
    @movies = current_user.reviews.includes(:movie)
  end

  def edit
    # プロフィール編集画面のサイドバーにブックマーク・レビューした映画数を表示するために変数を定義
    @bookmarks_movies = current_user.bookmark_movies.includes(:user).order(created_at: :desc)
    @movies = current_user.reviews.includes(:movie)
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
