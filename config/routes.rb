Rails.application.routes.draw do
  resources :plans
  resources :subscriptions
  resources :accounts
  resources :payment_notifications
  root to: 'visitors#index'
  devise_for :users, controllers: { :registrations => 'users/registrations',:invitations => 'users/invitations'}
end
