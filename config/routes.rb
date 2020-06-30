Rails.application.routes.draw do
  resources :messages
  resources :companies
  resources :applications do
    member do
      get 'messages'
    end
  end
  resources :positions
  resources :users do
    member do
      get 'applications'
      get 'company'
      get 'positions'
      get 'messages'
    end
  end
  
  post '/sessions', to: 'sessions#create'
end
