Rails.application.routes.draw do
  resources :memberships
  resources :addons
  resources :plans
  resources :contacts
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
