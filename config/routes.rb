Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  root 'users#new'
  resources :users

  resources :movies do
    resources :reviews, only: %i[new create edit update show destroy]
  end

  resources :likes, only: %i[create destroy]
end
