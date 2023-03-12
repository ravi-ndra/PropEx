Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount StripeEvent::Engine, at: '/webhooks'
  
  get 'dashboard/index'
  get "dashboard/sold"
  
  
  post "webhooks/create", to: "webhooks#create"
  post "checkouts/create", to: "checkouts#create"
  resources :properties #do 
  #   member do 
  #     put :publish
  #   end
  # end

  devise_for :users
  root 'public#main'
  
  get "public/about", to: "public#about"

  get '/search', to: 'properties#search'

end
