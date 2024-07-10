# frozen_string_literal: true

Rails.application.routes.draw do
  root 'user_particulars#show' # set root path of web app as /user_particulars/show for now

  devise_for :users, controllers: {
    registrations: 'users/registrations/registrations',
    passwords: 'users/registrations/passwords'
  }

  # Self-declared extra routes (must be before resources)
  get 'user_particulars/confirm'
  post 'user_particulars/:id/generate_2fa', to: 'user_particulars#generate_2fa', as: 'generate_2fa'
  
  # Resources: UserParticulars
  resources :user_particulars
  resources :ngo_users do
    member do
      post 'check_user' # Add this line for post action to verify user
      get 'verify', to: 'ngo_users#verify', as: 'verify'# Add this line for the verify action
      post 'verify', to: 'ngo_users#verify'
      post 'confirm_verify', to: 'ngo_users#confirm_verify'
    end
  end
end
