Rails.application.routes.draw do
  devise_for :users
  get 'products/index'
  get 'products/show'
  root 'home#index'
end
