# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :set_movie, only: %i[edit update destroy]
  skip_before_action :require_login, only: %i[index show search category]

  def index
    @q = Movie.ransack(params[:q])
    @movies = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])

    # 検索フォームが使用された場合、@searchedをtrueに設定
    @searched = !params[:q].blank?

    @categories = Category.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.new(movie_params)
    if @movie.save
      flash[:notice] = t('.success')
      redirect_to movie_path(@movie)
    else
      flash.now[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews.includes(:user).order(created_at: :desc)
  end

  def edit; end

  def update
    if @movie.update(movie_params)
      flash[:notice] = t('.success')
      redirect_to movie_path(@movie)
    else
      flash.now[:alert] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy!
    redirect_to movies_path
  end

  def search
    query = params[:q]
    @movies = Movie.where('title like ?', "%#{query}%")
    respond_to do |format|
      format.html { render partial: 'movies/search_results', locals: { movies: @movies } }
    end
  end

  def category
    @category = Category.find(params[:category_id])
    @movies = @category.movies.includes(:user).order(created_at: :desc).page(params[:page])
    @categories = Category.all
  end

  private

  def set_movie
    @movie = current_user.movies.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :synopsis, :thumbnail, :thumbnail_cache, :screening_time, :text_position,
                                  :text_color, :text_size, category_ids: [])
  end
end
