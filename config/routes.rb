Rails.application.routes.draw do
  devise_for :users
  resources :products, only: [:index, :show]
  resource :checkout, only: :show
  root 'home#index'

  namespace :carts do
    resource :add, only: :create
    resource :reduce, only: :create
    resource :remove, only: :destroy
  end
end
