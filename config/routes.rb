Rails.application.routes.draw do
  get 'cards/new'
  get 'users/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'items#index'
  resources :users, only:[:show]
  resources :items
  resources :cards, only: [:new, :create]
  resources :carts do
    resources :orders, only:[:index, :create, :show]
  end
  resources :cart_items, only:[:create, :edit, :update, :destroy]
end