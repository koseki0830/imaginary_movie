class MoviesController < ApplicationController
  before_action :set_movie, only: %i[edit update destroy]
  
  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.new(movie_params)
    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews.includes(:user).order(created_at: :desc)
  end

  def edit; end

  def update
    if @movie.update(movie_params)
      redirect_to movies_path
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy!
    redirect_to movies_path
  end

  def my_reviews_movies
    @movies = current_user.reviews.includes(:movie).map(&:movie)
  end

  def bookmarks
    @bookmarks_movies = current_user.bookmark_movies.includes(:user).order(created_at: :desc)
  end

  private
  
  def set_movie
    @movie = current_user.movies.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :synopsis, :thumbnail, :thumbnail_cache, :screening_time, category_ids: [])
  end
end
