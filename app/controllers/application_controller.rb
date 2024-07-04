# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user! # This will ensure that a user is logged in before accessing any page
  helper_method :current_user, :user_signed_in?
  layout :layout_by_resource
  def layout_by_resource
    user_signed_in? ? 'application' : 'userlogin'
  end
end
