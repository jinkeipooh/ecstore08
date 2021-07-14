Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items
  resources :carts do
    resources :orders, only:[:index, :create, :show]
  end
  resources :cart_items
end