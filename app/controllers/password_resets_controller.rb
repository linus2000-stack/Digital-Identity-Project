class PasswordResetsController < ApplicationController
  def new
    # Render the reset password page
  end

  def create
    user = User.find_by(email: params[:email])

    if user
      user.send_reset_password_instructions
      flash[:notice] = "You will receive an email with instructions on how to reset your password in a few minutes."
      redirect_to login_path
    else
      flash.now[:alert] = "Email address not found"
      render :new
    end
  end
end
