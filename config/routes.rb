Rails.application.routes.draw do
 
  resources :user_stocks, only: [:create, :destroy]
  devise_for :users
  root 'welcome#index'
  get 'about', to: 'welcome#about'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friend', to: 'users#search'
  resources :friendship, only: [:create, :destroy]
  resources :users, only: [:show]
end
