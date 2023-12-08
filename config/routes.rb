Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/api/v0/markets/search', to: 'api/v0/markets#search'

  namespace :api do
    namespace :v0 do
      resources :markets, only: [:index, :show] do
        member do
          get 'nearest_atms'
        end
        resources :vendors, only: [:index]
      end
      resources :vendors, only: [:show, :create, :update, :destroy]
    end
  end
  post '/api/v0/market_vendors', to: 'api/v0/market_vendors#create'
  delete '/api/v0/market_vendors', to: 'api/v0/market_vendors#delete'
  
end
