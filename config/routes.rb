Rails.application.routes.draw do
  resources :companies
  resources :applications
  resources :positions
  resources :users do
    member do
      get 'applications'
      get 'company'
      get 'positions'
    end
  end
  
  post '/sessions', to: 'sessions#create'
end
