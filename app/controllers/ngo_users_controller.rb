class NgoUsersController < ApplicationController
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
    @ngo_user = NgoUser.find(params[:id])
    @user_particular = UserParticular.find_by(unique_id: params[:unique_id], two_fa_passcode: params[:two_fa_passcode])

    if @user_particular
      flash.now[:notice] = "User found."
      @checked = true
    else
      flash.now[:alert] = "User not found."
      @checked = false
    end

    render :show
  end
end
