Rails.application.routes.draw do
  root 'welcome#index'

  get 'routes/find/', to: 'routes#find'
  get 'routes/find/:', to: 'routes#find2'
  get 'routes/new_from_xml/', to: 'routes#new_from_xml'
  post 'routes/new_from_xml/submit', to: 'routes#new_from_xml_results'
  resources :routes
  resources :cities
  resources :reports
  resources :mail_deliveries

  devise_for :users
end
