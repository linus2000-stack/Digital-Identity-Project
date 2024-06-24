class UserParticularsController < ApplicationController
  include UserParticularsHelper

  before_action :set_user_particular, only: [:show]
  def show; end
  # No need for content when using @user_particular from before_action
  
  def create
    if validate_user_particulars(UserParticular.new(user_particular_params))
      @user_particular = UserParticular.create_user_particular(user_particular_params)

      #Check if user particular creation was successful
      if @user_particular.persisted? 
        flash[:success] = "Digital ID was successfully created!"
        redirect_to @user_particular #redirects to /user_particulars/:id
      else 
        flash[:error] = ["Error creating digital id"]
        redirect_to user_particulars_confirm_path
      end
    
    #Invalid user_particular_params
    else 
      redirect_to user_particulars_confirm_path
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

  def set_user_particular
    @user_particular = UserParticular.find_by_id(params[:id])
    end

  def user_particular_params
    params.require(:user_particular).permit(:full_name, :phone_number, :secondary_phone_number, :country_of_origin, 
                                            :ethnicity, :religion, :gender, :date_of_birth, :date_of_arrival, 
                                            :photo_url, :birth_certificate_url, :passport_url)
  end
 
  def set_dropdown_options
    @countries = country_options
    @ethnicities = ethnicity_options
    @religions = religion_options
  end
  
  def validate_user_particulars(user_particular)
    error_messages_arr = []
  
    if !(user_particular[:full_name] =~ /^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžæÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$/u)
      error_messages_arr << "Full name can only contain valid letters and symbols."
    end
    
    #Change to phone number should only contain numbers and '-'
    if user_particular[:phone_number] =~ /[a-zA-Z]/
      error_messages_arr << "Phone number cannot contain letters."
    end
  
    #Change to secondary phone number should only contain numbers and '-'
    if user_particular[:secondary_phone_number] =~ /[a-zA-Z]/
      error_messages_arr << "Secondary phone number cannot contain letters."
    end
  
    #Check if selected option is in dropdown options
    if !user_particular[:country_of_origin].in?country_options
      error_messages_arr << "Select country of origin from the dropdown list."
    end

    if !user_particular[:ethnicity].in?ethnicity_options  
      error_messages_arr << "Select ethnicity from the dropdown list."
    end

    if !user_particular[:religion].in?religion_options
      error_messages_arr << "Select religion from the dropdown list."
    end
  
    if user_particular[:date_of_birth] > Date.today 
      error_messages_arr << "Date of birth cannot be in the future."
    end

    if user_particular[:date_of_arrival] > Date.today
      error_messages_arr << "Date of arrival cannot be in the future."
    end

    #Add condition which checks that date of arrival cannot be earlier than date of birth
    
    flash[:error] = error_messages_arr

    error_messages_arr.empty?
  end

end