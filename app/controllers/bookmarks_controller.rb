# frozen_string_literal: true

class BookmarksController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    current_user.bookmark(@movie)
  end

  def destroy
    @movie = current_user.bookmarks.find(params[:id]).movie
    current_user.unbookmark(@movie)
  end

  def index
    @movies = current_user.bookmark_movies.includes(:user).order(created_at: :desc).page(params[:page])
  end
end
