class NgoUsersController < ApplicationController
  def new
    # @ngo_users = NgoUser.all
    if params[:search].present?
      @ngo_users = NgoUser.where("name LIKE ?", "%#{params[:search]}%")
    else
      @ngo_users = NgoUser.all
    end
  end

  def show
    @ngo_user = NgoUser.find(params[:id])
    @user_particular = UserParticular.find_by(unique_id: params[:enable_id]) if params[:enable_id].present?
  end

  def index
  end

  def verify
    @ngo_user = NgoUser.find(params[:id])
    @user_particular = nil
  end

  def verify_user
    @ngo_user = NgoUser.find(params[:id])
    @user_particular = UserParticular.find_by(unique_id: params[:unique_id])

    if @user_particular
      flash.now[:notice] = "User found."
    else
      flash.now[:alert] = "User not found."
      @user_particular = nil
    end

    render :verify
  end
end
