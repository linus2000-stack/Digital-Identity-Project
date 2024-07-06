# frozen_string_literal: true

Rails.application.routes.draw do
  # Set root path of web app to /user_particulars/show for now
  root 'user_particulars#show'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions', # Updated sessions controller path
    passwords: 'users/passwords'
  }

  # Self-declared extra routes (must be before resources)
  get 'user_particulars/confirm'
  get 'ngo_users/verify'

  # Resources: UserParticulars
  resources :user_particulars
  resources :ngo_users

  # Custom routes for login, home, and reset password
  get 'login', to: 'users/sessions#new', as: 'login'
  post 'login', to: 'users/sessions#create' # Added post route for login
  delete 'logout', to: 'users/sessions#destroy', as: 'logout' # Added route for logout
  get 'home', to: 'home#index', as: 'home'
  get 'reset_password', to: 'users/passwords#new', as: 'reset_password'
  post 'reset_password', to: 'users/passwords#create' # Added post route for reset password
end
