Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  root 'users#new'
  resources :users

  resources :movies do
    resources :reviews, only: [:new, :create, :edit, :update, :show, :destroy] do
      resource :likes, only: [:create, :destroy]
    end
  end
end
