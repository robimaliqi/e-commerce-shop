Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :products, only: [:index, :show]

  post :search, to: "searches#show"
  get :search, to: "searches#show"

  namespace :stripe_event do
    post "/stripe/webhook", to: "webhook#event"
  end

  resource :checkout, only: [:show, :create] do
    resource :payment, only: :show
  end

  namespace :carts do
    resource :add, only: :create
    resource :reduce, only: :create
    resource :remove, only: :destroy
  end

  get 'contact_us/index'
end
