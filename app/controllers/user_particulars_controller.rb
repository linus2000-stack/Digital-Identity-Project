class UserParticularsController < ApplicationController
  def show
    # Retrieve the user particular by ID
    @user_particular = UserParticular.find_by_id(params[:id])
  end
  

  def create
    #create new userparticulars in database, retrieve item of new row 
    
    #TODO: Parse date format before passing to model???

    #id retrieve from the returned model
    @user_particular = UserParticular.create_user_particular(user_particular_params)
    
    #redirect to show
    redirect_to user_particular_path(@user_particular.id)
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

  def user_particular_params
    params.require(:user_particular)
    params[:user_particular]
  end
end
