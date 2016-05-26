Rails.application.routes.draw do
  root 'welcome#index'

  get 'routes/find/', to: 'routes#find'
  get 'routes/find/:', to: 'routes#find2'
  resources :routes
  resources :cities
  resources :reports
  resources :mail_deliveries

  devise_for :users
end
