class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end 

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    redirect_to login_path
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?

    # パスワード確認の検証を機能させます
    @user.password_confirmation = params[:user][:password_confirmation]
    # 一時トークンをクリアし、パスワードを更新する
    if @user.change_password(params[:user][:password])
      redirect_to login_path
    else
      render :edit
  end
end
