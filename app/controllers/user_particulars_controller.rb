class UserParticularsController < ApplicationController
  include UserParticularsHelper

  before_action :set_user_particular, only: [:show]
  def show; end # No need for content when using @user_particular from before_action
  
  def create
    @user_particular = UserParticular.new(user_particular_params) #Model object with keyed params
    if @user_particular.save #the .save method checks whether the @user_particular was actually saved in the database.
      flash[:notice] = "Digital ID was successfully created!"
      redirect_to @user_particular
    end
  end

  def new
    @user_particular = UserParticular.new #An empty Model object to store the new details to be keyed in
    set_dropdown_options # DRY up options population
  end

  def confirm
    @user_particular = UserParticular.new(user_particular_params) #The Model object to store the hidden keyed params
    # Use the session to store the data (or a separate model) if necessary.
  end

  def home; end

  private

  def user_particular_params
    params.require(:user_particular).permit(:full_name, :phone_number, :secondary_phone_number, :country_of_origin, :ethnicity, :religion, :gender, :date_of_birth, :date_of_arrival, :passport_photo, :birth_certificate, :passport, :other_identity_documents)
  end

  def set_user_particular
    @user_particular = UserParticular.find_by_id(params[:id])
  end

  def set_dropdown_options
    @countries = country_options
    @ethnicities = ethnicity_options
    @religions = religion_options
  end

end
