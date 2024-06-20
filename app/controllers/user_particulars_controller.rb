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
    @user_particular = user_particular_params
    @user_particular = UserParticular.create_user_particular(user_particular_params)
    flash[:notice] = "Digital ID was successfully created!"
    redirect_to user_particular_path(@user_particular.id)
  end

  def new
    @user_particular = UserParticular.new #create empty model instance to populate in form input!
    @countries = country_options
    @ethnicities = ethnicity_options
    @religions = religion_options
    #automatically renders app/views/user_particulars/new.html.erb    
  end

  def confirm
    #TODO: Rename to singular naming
    #@user_particular = params.permit(:full_name, :phone_number, :secondary_phone_number, :country_of_origin, :ethnicity, :religion, :gender, :date_of_birth, :date_of_arrival, :birth_certificate, :passport, :other_identity_documents)
    @user_particular = UserParticular.new #create empty model instance to populate in form input INVISIBLE!    
    @user_particulars = user_particular_params
    session[:user] = @user_particulars
    #automatically renders app/views/user_particulars/confirm.html.erb
  end

  def home
    #automatically renders app/views/user_particulars/home.html.erb
  end

  private

  def user_particular_params
    params.require(:user_particular).permit(:full_name, :phone_number, :secondary_phone_number, :country_of_origin, :ethnicity, :religion, :gender, :date_of_birth, :date_of_arrival, :passport_photo, :birth_certificate, :passport, :other_identity_documents)
  end

end
