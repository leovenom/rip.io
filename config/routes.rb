Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :attractions do
    resources :bookings
  end

  get '/my_attractions', to: 'pages#my_attractions'
  get '/my_bookings', to: 'pages#my_bookings'
  get '/profile', to: 'pages#profile'
  get '/be_a_guide', to: 'pages#be_a_guide'
  delete '/my_bookings', to: 'bookings#destroy', as: 'my_bookings_destroy'

  resources :personalities

  get '/my_personalities', to: 'pages#my_personalities'
end

