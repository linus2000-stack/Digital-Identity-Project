class UserParticularsController < ApplicationController
  include UserParticularsHelper

  before_action :set_user_particular, only: [:show]
  def show
    # Retrieve the user particular by ID
    @user_particular = UserParticular.find_by_id(params[:id])
  end
  

  def create
    @user_particular = UserParticular.new(user_particular_params) #Model object with keyed params
    if @user_particular.save #the .save method checks whether the @user_particular was actually saved in the database.
      flash[:notice] = "Digital ID was successfully created!"
      redirect_to @user_particular
    end


    #create new userparticulars in database, retrieve item of new row 
    
    #TODO: Parse date format before passing to model???

    #id retrieve from the returned model
    #@user_particular = UserParticular.create_user_particular(params.permit(:full_name, :phone_number, :secondary_phone_number, :country_of_origin, :ethnicity, :religion, :gender, :date_of_birth, :date_of_arrival))
    
    #redirect to show
    #flash[:notice] = "User successfully created!"
    #redirect_to user_particular_path(@user_particular.id)
  end

  def new
    #automatically renders app/views/user_particulars/new.html.erb
    @user_particular = UserParticular.new(session.fetch(:user_particular_params, {}))
    #An Model object based on session details
    set_dropdown_options # Only populate options if it's a fresh visit to the page.
  end

  def confirm
    session[:user_particular_params] = user_particular_params # Use the session to store the model
    @user_particular = UserParticular.new(user_particular_params) #The Model object to store the hidden keyed params
    if validate_user_particulars(@user_particular)
      # Render confirm if validation passes
      render :confirm
    else
      # Render new with an error message if validation fails
      flash[:error] = flash[:error].join(", ")
      render :new
    end
  end

  def home; end

  private

  def user_particular_params
    params.require(:user_particular).permit(:full_name, :phone_number, :secondary_phone_number, :country_of_origin, :ethnicity, :religion, :gender, :date_of_birth, :date_of_arrival, :passport_photo, :birth_certificate, :passport, :other_identity_documents)
    #params.require(:user_particular)
    params[:user_particular]
  end

  def set_user_particular
    @user_particular = UserParticular.find_by_id(params[:id])
  end

  def set_dropdown_options
    @countries = country_options
    @ethnicities = ethnicity_options
    @religions = religion_options
  end

  #def confirm
    #TODO: Rename to singular naming
    #@user_particular = params.permit(:full_name, :phone_number, :secondary_phone_number, :country_of_origin, :ethnicity, :religion, :gender, :date_of_birth, :date_of_arrival, :birth_certificate, :passport, :other_identity_documents)
    #automatically renders app/views/user_particulars/confirm.html.erb
    #correct validation for full name, phone number, secondary phone number, date of birth, date of arrival
    #render confirm
  #   if validate_user_particulars(@user_particular)
  #     # Render confirm if validation passes
  #     render :confirm
  #   else
  #     # Render new with an error message if validation fails
  #     flash[:error] = flash[:error].join(", ")
  #     render :new
  #   end

  #   #incorrect validation
  #   #return to new page
  # end


  def validate_user_particulars(user_particular)
    valid = true
    flash[:error] = []

    if user_particular[:full_name] =~ /\d/
      valid = false
      flash[:error] << "Full name cannot contain numbers."
    end

    if user_particular[:phone_number] =~ /[a-zA-Z]/
      valid = false
      flash[:error] << "Phone number cannot contain letters."
    end

    if user_particular[:secondary_phone_number] =~ /[a-zA-Z]/
      valid = false
      flash[:error] << "Secondary phone number cannot contain letters."
    end

    if user_particular[:country_of_origin] =~ /[^a-zA-Z\s]/
      valid = false
      flash[:error] << "Country of origin should only contain letters."
    end

    if user_particular[:date_of_birth] or user_particular[:date_of_arrival] > Date.today
      valid = false
      flash[:error] << "Date not valid."
    end

    # Add more validations if necessary

    valid
  end

  
end
