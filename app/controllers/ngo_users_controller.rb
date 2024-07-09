class NgoUsersController < ApplicationController
  before_action :set_ngo_user, only: [:show, :check_user, :verify_user]

  def new
  end

  def show
    @ngo_user = NgoUser.find(params[:id])
    if params[:unique_id].present?
      @user_particular = UserParticular.find_by(unique_id: params[:unique_id])
      if @user_particular
        flash.now[:notice] = "Unique ID found. Please enter your 2FA code."
        @unique_id_exists = true
      else
        flash.now[:alert] = "Unique_ID does not exist. Please try again."
        @unique_id_exists = false
      end
    end
  end

  def index
    # @ngo_users = NgoUser.all
    if params[:search].present?
      @ngo_users = NgoUser.where("name LIKE ?", "%#{params[:search]}%")
    else
      @ngo_users = NgoUser.all
    end
  end

  def check_user
    @unique_id = params[:unique_id]
    @two_fa_passcode = params[:two_fa_passcode]
    @ngo_user = NgoUser.find(params[:id])
    
    # Perform your unique ID check logic here and set @unique_id_exists accordingly
    @unique_id_exists = true # Example, replace with actual logic

    if @unique_id_exists
      # Redirect to verify page with checked parameter
      Rails.logger.debug "Redirecting to verify_user_ngo_user_path with @ngo_user.id=#{@ngo_user.id}, unique_id=#{@unique_id}, checked=true"
      redirect_to verify_user_ngo_user_path(@ngo_user, unique_id: @unique_id, checked: true) 
    else
      @unique_id_exists = false
      render :show
    end
  end

  
  def verify_user
    @unique_id = params[:unique_id]
    @two_fa_passcode = params[:two_fa_passcode]
    # Perform your verification logic here and set @checked accordingly
    @checked = false # Example, replace with actual logic

    if @checked
      # Render the verify page with user particulars
      render :verify, locals: { checked: true }
    else
      redirect_to @ngo_user
    end
  end

  private

  def set_ngo_user
    @ngo_user = NgoUser.find(params[:id])
  end
end
