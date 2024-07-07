class NgoUsersController < ApplicationController
  def new
  end

  def show
    @ngo_user = NgoUser.find(params[:id])
    @user_particular = UserParticular.find_by(unique_id: params[:enable_id]) if params[:enable_id].present?
  end

  def index
  end

  def verify
    @ngo_user = NgoUser.find(params[:id])
    @user_particular = UserParticular.new # Initialize to avoid nil error in form
  end

  def verify_user
    @ngo_user = NgoUser.find(params[:id])
    @user_particular = UserParticular.find_by(unique_id: params[:unique_id])

    if @user_particular
      flash.now[:notice] = "User found."
    else
      flash.now[:alert] = "User not found."
      @user_particular = UserParticular.new
    end

    render :verify
  end
end
