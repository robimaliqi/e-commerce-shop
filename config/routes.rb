Rails.application.routes.draw do
  devise_for :users
  resources :products, only: [:index, :show]
  resource :checkout, only: :show
  post :search, to: "searches#show"
  root 'home#index'

  namespace :carts do
    resource :add, only: :create
    resource :reduce, only: :create
    resource :remove, only: :destroy
  end
end
