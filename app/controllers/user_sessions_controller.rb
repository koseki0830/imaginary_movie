class UserSessionsController < ApplicationController
  skip_before_action :require_login
  
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      flash[:notice] = "ログインしました!"
      redirect_to movies_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end
