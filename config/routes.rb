Rails.application.routes.draw do
  root 'welcome#index'

  resources :routes
  resources :cities

  devise_for :users
end
