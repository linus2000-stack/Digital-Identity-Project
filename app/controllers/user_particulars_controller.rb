class UserParticularsController < ApplicationController
  include UserParticularsHelper
  before_action :authenticate_user!
  before_action :set_user_particular, only: %i[show edit]
  before_action :set_ngo_users

  def show
    @bulletins = Bulletin.all.order(updated_at: :desc)
  end
  # No need for content when using @user_particular from before_action

  def document
    @back_path = root_path
  end
  # No need for content when using @user_particular from before_action

  def create
    error_messages_arr = validate_user_particulars(UserParticular.new(user_particular_params))
    flash[:error] = error_messages_arr

    # Check if validation passes
    if error_messages_arr.empty?
      @user_particular = UserParticular.create_user_particular(user_particular_params)

      # Check if user particular creation was successful
      if @user_particular.persisted?
        @user_particular.profile_picture.attach(params[:user_particular][:profile_picture])

        flash[:success] = 'Digital ID was successfully created!'
        redirect_to @user_particular # redirects to /user_particulars/:id
      else
        flash[:error_message] = 'Digital ID creation failed. Please try again.'
        redirect_to user_particulars_confirm_path(user_particular: user_particular_params) # pass user_particular_params into params of confirm action
      end
    else
      # Failed validation
      # pass user_particular_params into params of confirm action
      flash[:error_message] = 'Digital ID creation failed. Please try again.'
      redirect_to user_particulars_confirm_path(user_particular: user_particular_params) # pass user_particular_params into params of confirm action
    end
  end

  def new
    @back_path = root_path
    # Fills up form with previously entered data
    @user_particular = UserParticular.new(session.fetch(session[:user_particular_params], {}))
    set_dropdown_options
  end

  def confirm
    session[:user_particular_params] = user_particular_params # Use the session to store the model
    @user_particular = UserParticular.new(user_particular_params) # The Model object to store the hidden keyed params
    error_messages_arr = validate_user_particulars(@user_particular)
    flash[:error] = error_messages_arr

    if error_messages_arr.empty?
      # Render confirm if validation passes
      render :confirm
    else
      # Render error message(s) in form if validation fails
      flash[:error_message] = 'Please fix the error(s) below:'
      redirect_to new_user_particular_path
    end
  end

  def edit
    @back_path = root_path
    set_dropdown_options

    if params[:user_particular]
      @user_particular = UserParticular.new(user_particular_params)
      @user_particular.id = params[:id] # Required for error flow
    else
      @user_particular = UserParticular.find(params[:id])
    end
  end

  def update
    error_messages_arr = validate_user_particulars(UserParticular.new(user_particular_params))
    flash[:error] = error_messages_arr

    # Check if validation passes
    if error_messages_arr.empty?
      logger.debug "OVER HERE! UPDATE! #{user_particular_params}"
      @user_particular = UserParticular.update_user_particular(params[:id], user_particular_params)

      # Check if edit was successful
      if @user_particular
        flash[:success] = 'Digital ID was successfully edited!'
        UserParticular.reset_verification(params[:id]) # Set status to pending and reset verifier_ngo
        redirect_to @user_particular # redirects to /user_particulars/:id
      else
        flash[:error_message] = 'Edit failed. Please fix the error(s) below:'
        redirect_to edit_user_particular_path(params[:id], user_particular: user_particular_params)
      end
    else
      # Failed validation
      flash[:error_message] = 'Edit failed. Please fix the error(s) below:'
      redirect_to edit_user_particular_path(params[:id], user_particular: user_particular_params)
    end
  end

  def history
    @back_path = root_path
    @user_history = UserHistory.where(user_id: params[:id]).order(updated_at: :desc)
  end

  # Retrieves user particular object linked to user object
  def set_user_particular
    @user_particular = current_user.user_particular
  end

  def user_particular_params
    params.require(:user_particular).permit(:full_name, :phone_number, :secondary_phone_number, :country_of_origin,
                                            :ethnicity, :religion, :gender, :date_of_birth, :date_of_arrival,
                                            :photo_url, :birth_certificate_url, :passport_url, :user_id,
                                            :phone_number_country_code, :secondary_phone_number_country_code,
                                            :full_phone_number, :full_secondary_phone_number, :profile_picture).tap do |whitelisted|
      # Check if ethnicity, religion, or gender is "Others" and replace with values from others hash if present
      if whitelisted[:ethnicity] == 'Others' && params[:others].present?
        whitelisted[:ethnicity] =
          params[:others][:ethnicity]
      end
      if whitelisted[:religion] == 'Others' && params[:others].present?
        whitelisted[:religion] =
          params[:others][:religion]
      end
      whitelisted[:gender] = params[:others][:gender] if whitelisted[:gender] == 'Others' && params[:others].present?
    end
  end

  def set_dropdown_options
    @countries = country_options
    @ethnicities = ethnicity_options
    @religions = religion_options
    @country_code_options = country_code_options
  end

  def generate_2fa
    @user_particular = UserParticular.find(params[:id])
    @user_particular.generate_2fa_secret
    if @user_particular.save
      respond_to do |format|
        format.json { render json: { two_fa_passcode: @user_particular.two_fa_passcode } }
      end
    else
      render json: { error: 'Failed to generate 2FA passcode' }, status: :unprocessable_entity
    end
  end

  def validate_user_particulars(user_particular)
    error_messages_arr = []

    unless user_particular[:full_name] =~ /^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžæÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$/u
      error_messages_arr << 'Full name can only contain valid letters and symbols.'
    end

    if user_particular[:phone_number] =~ /[^0-9-]/
      error_messages_arr << 'Phone number can only contain numbers and hyphens.'
    end

    if user_particular[:secondary_phone_number] =~ /[^0-9-]/
      error_messages_arr << 'Secondary phone number can only contain numbers and hyphens.'
    end

    if user_particular[:secondary_phone_number_country_code].present? || user_particular[:secondary_phone_number].present?
      if user_particular[:secondary_phone_number_country_code].blank?
        error_messages_arr << 'Secondary country code must exist if secondary phone number exists.'
      end

      if user_particular[:secondary_phone_number].blank?
        error_messages_arr << 'Secondary phone number must exist if secondary country code exists.'
      end
    end

    # Check if selected option is in dropdown options
    unless user_particular[:country_of_origin].in? country_options
      error_messages_arr << 'Select country of origin from the dropdown list.'
    end

    unless user_particular[:ethnicity].in? ethnicity_options
      error_messages_arr << 'Select ethnicity from the dropdown list.'
    end

    unless user_particular[:religion].in? religion_options
      error_messages_arr << 'Select religion from the dropdown list.'
    end

    if Date.parse(user_particular[:date_of_birth].to_s) > Date.today
      error_messages_arr << 'Date of birth cannot be in the future.'
    end

    if Date.parse(user_particular[:date_of_arrival].to_s) > Date.today
      error_messages_arr << 'Date of arrival cannot be in the future.'
    end

    # Add condition which checks that date of arrival cannot be earlier than date of birth
    if Date.parse(user_particular[:date_of_arrival].to_s) < Date.parse(user_particular[:date_of_birth].to_s)
      error_messages_arr << 'Date of arrival cannot be earlier than date of birth.'
    end

    error_messages_arr
  end

  def family
    @back_path = root_path
    @user_particular = current_user.user_particular
  end

  private

  def set_ngo_users
    @ngo_users = NgoUser.all
    @user = current_user
  end
end
