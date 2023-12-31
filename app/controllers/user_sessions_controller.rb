# frozen_string_literal: true

class UserSessionsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      flash[:notice] = t('.success')
      redirect_to movies_path
    else
      flash.now[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end
