class MyReviewMoviesController < ApplicationController

  def index
    @movies = current_user.reviews
                                  .joins(:movie)
                                  .select('distinct on (movies.id) movies.*, reviews.id as review_id, reviews.movie_id')
                                  .order('movies.id, reviews.created_at desc')
                                  .page(params[:page])
  end
end
