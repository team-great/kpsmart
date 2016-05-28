Rails.application.routes.draw do
  root 'welcome#index'

  get 'routes/find/', to: 'routes#find'
  get 'routes/find/results', to: 'routes#results'
  resources :routes
  resources :cities
  resources :reports
  resources :mail_deliveries

  devise_for :users
end
