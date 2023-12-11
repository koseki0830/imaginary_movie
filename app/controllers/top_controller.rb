# frozen_string_literal: true

class TopController < ApplicationController
  skip_before_action :require_login

  def index; end

  def terms; end
end
