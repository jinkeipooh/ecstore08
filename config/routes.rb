Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items
  resources :carts
  resources :cart_items
end