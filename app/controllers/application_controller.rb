# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    flash[:alert] = t('defaults.message.require_login')
    redirect_to main_app.login_path
  end
end
