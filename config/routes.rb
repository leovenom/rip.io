Rails.application.routes.draw do

  get 'conversations/index'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :guides, only: [:index, :show, :update]

  resources :conversations, only: [:index, :show] do
    resources :messages, only: [:create]
  end

  resources :attractions do
    resources :tours
  end

  resources :personalities do
    resources :tours
  end

  resources :tours do
    resources :reviews
    resources :bookings, only: [:create]
    resources :conversations, only: [:new, :create]
  end

  resources :bookings, only: [:edit, :update, :destroy]

  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end

  get '/my_attractions', to: 'pages#my_attractions'
  get '/my_bookings', to: 'pages#my_bookings'
  get '/my_tours', to: 'pages#my_tours'
  get '/profile', to: 'pages#profile'
  get '/be_a_guide', to: 'pages#be_a_guide'
  delete '/my_bookings', to: 'bookings#destroy', as: 'my_bookings_destroy'
  patch 'update_to_guide', to: 'users#update_to_guide', as: 'update_to_guide'


  get '/my_personalities', to: 'pages#my_personalities'

end

