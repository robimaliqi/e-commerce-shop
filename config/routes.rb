Rails.application.routes.draw do
  devise_for :users
  resources :products, only: [:index, :show]
  root 'home#index'
end
