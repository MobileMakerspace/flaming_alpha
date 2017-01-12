Rails.application.routes.draw do
  resources :plans
  root to: 'visitors#index'
  devise_for :users
end
