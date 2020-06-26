Rails.application.routes.draw do
  resources :companies
  resources :applications
  resources :positions
  resources :users
  
  post '/sessions', to: 'sessions#create'
end
