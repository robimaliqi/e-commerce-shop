Rails.application.routes.draw do
  get 'products/index'
  get 'products/show'
  root 'home#index'
end
