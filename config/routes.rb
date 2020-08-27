Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  root to: 'pages#home'
  get 'pages/about'
  get 'pages/contact'
  devise_for :users, path: '', path_names: {
  	sign_in: 'login',
  	sign_out: 'logout',
  	sign_up: 'register'
  }
  
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friend', to: 'users#search_friend'
  get 'search_stock', to: 'stocks#search'
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:show]
end
