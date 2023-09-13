Rails.application.routes.draw do
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  root 'users#new'
  resources :users

  resources :movies do
    resources :reviews, only: %i[new create update edit show destroy]
  end
end
