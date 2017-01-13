Rails.application.routes.draw do
  resources :plans
  resources :subscriptions
  root to: 'visitors#index'
  devise_for :users
end
