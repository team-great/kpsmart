Rails.application.routes.draw do
  root 'welcome#index'

  get 'routes/find/', to: 'routes#find'
  get 'routes/find/results', to: 'routes#results'

  resources :routes
  resources :cities
  resources :mail_deliveries

  scope "reports" do
    get '/', to: 'reports#index'
    get '/revenue', to: 'reports#revenue'
  end

  devise_for :users
end
