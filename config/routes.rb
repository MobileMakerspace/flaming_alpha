Rails.application.routes.draw do
  resources :addons
  resources :plans
  resources :contacts
  root to: 'visitors#index'
  devise_for :users
end
