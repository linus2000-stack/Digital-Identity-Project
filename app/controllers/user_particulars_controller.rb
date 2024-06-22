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
  end

  def new
    #automatically renders app/views/user_particulars/new.html.erb
    @user_particular = UserParticular.new(session.fetch(:user_particular_params, {}))
    set_dropdown_options 
  end

  def confirm
    session[:user_particular_params] = user_particular_params # Use the session to store the model
    @user_particular = UserParticular.new(user_particular_params) #The Model object to store the hidden keyed params
    if validate_user_particulars(@user_particular)
      # Render confirm if validation passes
      render :confirm
    else
      # Render new error message(s) if validation fails
      redirect_to new_user_particular_path
    end
  end

  def home; end

  def user_particular_params
    params.require(:user_particular).permit(:full_name, :phone_number, :secondary_phone_number, :country_of_origin, 
                                            :ethnicity, :religion, :gender, :date_of_birth, :date_of_arrival, 
                                            :photo_url, :birth_certificate_url, :passport_url)
  end

  def set_user_particular
    @user_particular = UserParticular.find_by_id(params[:id])
  end

  def set_dropdown_options
    @countries = country_options
    @ethnicities = ethnicity_options
    @religions = religion_options
  end
  
  def validate_user_particulars(user_particular)
    error_messages_arr = []
  
    if user_particular[:full_name] =~ /\d/
      error_messages_arr << "Full name cannot contain numbers."
    end
  
    if user_particular[:phone_number] =~ /[a-zA-Z]/
      error_messages_arr << "Phone number cannot contain letters."
    end
  
    if user_particular[:secondary_phone_number] =~ /[a-zA-Z]/
      error_messages_arr << "Secondary phone number cannot contain letters."
    end
  
    if user_particular[:country_of_origin] =~ /[^a-zA-Z\s]/
      error_messages_arr << "Country of origin should only contain letters."
    end
  
    if user_particular[:date_of_birth] > Date.today 
      error_messages_arr << "Date of birth cannot be in the future."
    end

    if user_particular[:date_of_arrival] > Date.today
      error_messages_arr << "Date of arrival cannot be in the future."
    end
    
    flash[:error] = error_messages_arr.join(", ") unless error_messages_arr.empty?

    error_messages_arr.empty?
  end
  

  
end
