class BookmarksController < ApplicationController
  
  def create
    movie = Movie.find(params[:movie_id])
    current_user.bookmark(movie)
    redirect_back fallback_location: root_path
  end

  def destroy
    movie = current_user.bookmarks.find(params[:id]).movie
    current_user.unbookmark(movie)
    redirect_back fallback_location: root_path
  end
end
