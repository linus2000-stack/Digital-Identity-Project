class UserParticularsController < ApplicationController
  def show
    #automatically renders app/views/user_particulars/show.html.erb
  end

  def create
    #create new userparticulars in database, retrieve item of new row 
    #remember to reverse date format before passing to model
    #id retrieve from the returned model
    # calls show method, displays userparticulars of certain id
    redirect_to user_particular_path(1)
  end

  def new
    #automatically renders app/views/user_particulars/new.html.erb
  end

  def confirm
    #automatically renders app/views/user_particulars/confirm.html.erb
  end

  def home
    #automatically renders app/views/user_particulars/home.html.erb
  end
end
