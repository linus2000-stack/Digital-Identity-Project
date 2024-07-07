# frozen_string_literal: true

Rails.application.routes.draw do
  root 'user_particulars#show' # set root path of web app as /user_particulars/show for now

  devise_for :users, controllers: {
    registrations: 'users/registrations/registrations',
    sessions: 'users/registrations/sessions', # Update sessions controller
    passwords: 'users/registrations/passwords'
  }

  # Self-declared extra routes (must be before resources)
  get 'user_particulars/confirm'
  get 'ngo_users/verify'

  # Resources: UserParticulars
  resources :user_particulars
  resources :ngo_users

  # Custom routes for login, home, and reset password
  get 'login', to: 'users/registrations/sessions#new', as: 'login'
  get 'home', to: 'home#index', as: 'home'
  get 'reset_password', to: 'password_resets#new', as: 'reset_password'
  post 'reset_password', to: 'password_resets#create' # Add post route for reset password
end
