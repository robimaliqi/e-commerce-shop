Rails.application.routes.draw do
  devise_for :users
  resources :products, only: [:index, :show]
  post :search, to: "searches#show"
  get :search, to: "searches#show"
  root 'home#index'

  resource :checkout, only: [:show, :create] do
    resource :payment, only: :show
  end

  namespace :carts do
    resource :add, only: :create
    resource :reduce, only: :create
    resource :remove, only: :destroy
  end
end
