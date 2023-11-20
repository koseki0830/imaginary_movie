# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'top#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'mypage', to: 'users#show'
  get 'rankings/sum', to: 'rankings#sum'

  resources :users, only: %i[new create update] do
    get :edit, on: :collection
  end

  resources :movies do
    resources :reviews, only: %i[new create edit update show destroy] do
      resources :comments, only: %i[create destroy], shallow: true
    end
    get :my_reviews_movies, on: :collection
    get :bookmarks, on: :collection
    get :search, on: :collection
  end

  resources :likes, only: %i[create destroy]
  resources :bookmarks, only: %i[create destroy]
  resources :password_resets, only: %i[new create edit update]
  resources :thumbnails, only: %i[create new]
  resources :photos, only: %i[index]
end
