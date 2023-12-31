# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'top#index'
  get 'terms', to: 'top#terms'
  get 'privacy_policy', to: 'top#privacy_policy'
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
    get :search, on: :collection
    get 'category/:category_id', on: :collection, to: 'movies#category', as: :category
  end

  resources :likes, only: %i[create destroy]
  resources :bookmarks, only: %i[create destroy index]
  resources :my_review_movies, only: %i[index]
  resources :recommends, only: %i[index]
  resources :password_resets, only: %i[new create edit update]
  resources :photos, only: %i[index]
end
