Rails.application.routes.draw do
  devise_for :users
  root 'user_particulars#home' # set home path of web app as /user_particulars/home for now

  # Self-declared extra routes (must be before resources)
  get 'user_particulars/confirm'
  get 'user_particulars/home'

  # Resources: UserParticulars
  resources :user_particulars
end
