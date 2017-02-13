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
  resources :keys
  resources :credit_notes, only: [:show, :update]
  resources :invoices, only: [:show, :update]
  resources :payments, only: [:show, :update]
  resources :billings, only: [:create]
  resources :settings
  root to: 'visitors#index'
  devise_for :users, controllers: { :registrations => 'users/registrations',:invitations => 'users/invitations'}
  resources :users, only: [:index, :show, :update]
  post "/hook" => "payment_notifications#create"
end
