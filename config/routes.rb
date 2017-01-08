Rails.application.routes.draw do
  namespace :admin do
    resources :memberships
resources :users
resources :addons
resources :contacts
resources :payment_notifications
resources :plans
resources :invoicing_ledger_items

    root to: "memberships#index"
  end

  resources :addons
  resources :plans
  resources :contacts do
    resources :memberships
  end
  resources :members

  root to: 'visitors#index'
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  post "/hook" => "payment_notifications#create"
  get '/payments' => "payment_notifications#index", :as => 'payment_notifications'
  get '/payments/:id' => 'payment_notifications#show', :as => 'payment_notification'

end
