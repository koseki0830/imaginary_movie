Rails.application.routes.draw do
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  root 'users#new'
  resources :users

  resources :movies do
    resources :reviews, only: %i[new create edit update show destroy] do
      resources :comments, only: %i[create destroy], shallow: true
    end
  end

  resources :likes, only: %i[create destroy]
end
