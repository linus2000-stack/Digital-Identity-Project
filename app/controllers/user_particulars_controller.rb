class UserParticularsController < ApplicationController
  include UserParticularsHelper
  def show
    # Retrieve the user particular by ID
    @user_particular = UserParticular.find_by_id(params[:id])
  end
  

  def create
    #create new userparticulars in database, retrieve item of new row 
    
    #TODO: Parse date format before passing to model???

    #id retrieve from the returned model
    @user_particular = UserParticular.create_user_particular(params.permit(:full_name, :phone_number, :secondary_phone_number, :country_of_origin, :ethnicity, :religion, :gender, :date_of_birth, :date_of_arrival))
    
    #redirect to show
    redirect_to user_particular_path(@user_particular.id)
  end

  def new
    #automatically renders app/views/user_particulars/new.html.erb
    @countries = country_options
    @ethnicities = ethnicity_options
    @religions = religion_options
  end

  def confirm
    #TODO: Rename to singular naming
    @user_particular = params.permit(:full_name, :phone_number, :secondary_phone_number, :country_of_origin, :ethnicity, :religion, :gender, :date_of_birth, :date_of_arrival, :birth_certificate, :passport, :other_identity_documents)
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
