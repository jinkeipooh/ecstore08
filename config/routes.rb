Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'items#index'
  resources :users, only:[:show]
  resources :items
  resources :carts do
    resources :orders, only:[:index, :create, :show]
  end
  resources :cart_items, only:[:create, :edit, :update, :destroy]
end