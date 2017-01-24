Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :payment_notifications
    resources :plans
    resources :subscriptions

    root to: "users#index"
  end

  resources :plans
  resources :subscriptions
  resources :accounts
  resources :payment_notifications
  root to: 'visitors#index'
  devise_for :users, controllers: { :registrations => 'users/registrations',:invitations => 'users/invitations'}
end
