class BookmarksController < ApplicationController
  
  def create
    @movie = Movie.find(params[:movie_id])
    current_user.bookmark(@movie)
  end

  def destroy
    @movie = current_user.bookmarks.find(params[:id]).movie
    current_user.unbookmark(@movie)
  end
end
