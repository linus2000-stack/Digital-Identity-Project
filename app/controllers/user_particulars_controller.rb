# frozen_string_literal: true

include UserParticularsHelperclass UserParticularsController < ApplicationController # For Model UserParticulars

before_action :set_user_particular, only: [:show]
def show; end
# No need for content when using @user_particular from before_action

def create
  @user_particular = UserParticular.new(user_particular_params) # Model object with keyed params
  # the .save method checks whether the @user_particular was actually saved in the database.
  return unless @user_particular.save

  flash[:notice] = 'Digital ID was successfully created!'
  redirect_to @user_particular
end

def new
  @user_particular = UserParticular.new(session.fetch(:user_particular_params, {}))
  # An Model object based on session details
  set_dropdown_options # Only populate options if it's a fresh visit to the page.
end

def confirm
  session[:user_particular_params] = user_particular_params # Use the session to store the model
  @user_particular = UserParticular.new(user_particular_params) # The Model object to store the hidden keyed params
end

def home; end

  private

def user_particular_params
  params.require(:user_particular).permit(:full_name, :phone_number, :secondary_phone_number, :country_of_origin,
                                          :ethnicity, :religion, :gender, :date_of_birth, :date_of_arrival,
                                          :passport_photo, :birth_certificate, :passport, :other_identity_documents)
end

def set_user_particular
  @user_particular = UserParticular.find_by_id(params[:id])
end

def set_dropdown_options
  @countries = country_options
  @ethnicities = ethnicity_options
  @religions = religion_options
end
