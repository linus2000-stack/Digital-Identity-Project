Rails.application.routes.draw do
  root 'user_particulars#home' #set home path of web app as /user_particulars/home for now
  
  #Resources: UserParticulars
  resources :user_particulars

  #Self-declared extra routes
  get 'user_particulars/confirm'
  get 'user_particulars/home'

end
