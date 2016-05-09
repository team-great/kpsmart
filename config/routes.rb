Rails.application.routes.draw do
  root 'welcome#index'

  resources :routes
  resources :cities
  resources :reports
  resources :mail_deliveries

  devise_for :users
end
