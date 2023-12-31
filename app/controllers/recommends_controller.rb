class RecommendsController < ApplicationController

  def index
    @movies = current_user.top_categories_movies
  end
end
