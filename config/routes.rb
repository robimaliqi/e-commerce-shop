Rails.application.routes.draw do
  devise_for :users
  resources :products, only: [:index, :show]
  root 'home#index'

  namespace :carts do
    resource :add, only: :create
  end
end
