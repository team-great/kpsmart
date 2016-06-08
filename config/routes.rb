Rails.application.routes.draw do
  root 'welcome#index'

  get 'routes/find/', to: 'routes#find'
  get 'routes/find/results', to: 'routes#results'

  get 'log', as: 'event_log_path', to: 'event_log#index'

  resources :routes
  resources :cities
  resources :mail_deliveries

  scope "reports" do
    get '/', as: 'reports_url', to: 'reports#index'
    get '/revenue', to: 'reports#revenue'
  end

  devise_for :users
end
