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
    # The rest of your show method logic here
  end

  def index
  end

  def verify
  end
end
