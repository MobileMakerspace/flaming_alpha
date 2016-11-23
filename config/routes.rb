Rails.application.routes.draw do
  resources :contacts
  root to: 'visitors#index'
  devise_for :users
end
