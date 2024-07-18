class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      render json: { message: "Welcome #{@user.username}" }, status: :ok
    else
      render json: { errors: 'Incorrect username or password' }, status: :unauthorized
    end
  end
end
