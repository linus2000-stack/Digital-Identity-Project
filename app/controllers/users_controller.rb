class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: 'Registration Successful' }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: { message: 'Information Updated' }
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :phone_number, :password, :password_confirmation, :status)
  end

end
