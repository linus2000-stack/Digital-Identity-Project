class NgoUsersController < ApplicationController
  def new
  end

  def show
    @back_path = ngo_users_path
    @ngo_user = NgoUser.find(params[:id])
    nil unless params[:unique_id].present?
  end

  def index
    @back_path = new_user_session_path
    # @ngo_users = NgoUser.all
    @ngo_users = if params[:search].present?
                   NgoUser.where('name LIKE ?', "%#{params[:search]}%")
                 else
                   NgoUser.all
                 end
  end

  def check_user
    @back_path = ngo_users_path
    @ngo_user = NgoUser.find(params[:id])
    @user_particular = UserParticular.find_by(unique_id: params[:unique_id], two_fa_passcode: params[:two_fa_passcode])
    if @user_particular
      redirect_to verify_ngo_user_path(@ngo_user, unique_id: @user_particular.unique_id)
    else
      flash[:alert] = 'User not found. Please check your Unique ID and 2FA Code.'
      render :show
    end
  end

  def verify
    @back_path = ngo_user_path
    @ngo_user = NgoUser.find(params[:id])
    logger.debug "params[:unique_id]: #{params[:unique_id]}"
    @user_particular = UserParticular.find_by(unique_id: params[:unique_id])
    logger.debug "User Particular: #{@user_particular}"
    # Any additional logic you want to include before rendering the verify view
    # render 'verify' is implicit
    # flash[:notice] = "Verification successful."
    # redirect_to ngo_user_path(@ngo_user, id: params[:id], commit:'Verify')
  end

  def confirm_verify
    @back_path = ngo_user_path
    @ngo_user = NgoUser.find(params[:id])
    @user_particular = UserParticular.find_by(unique_id: params[:unique_id])
    #@user_particular = UserParticular.includes(:verified_by_ngo_user).find_by(id: params[:id])
    # Add any verification logic here
    #redirect_to "http://localhost:3000/ngo_users/:id"
    #@user_particular.update(status: 'verified')
    logger.debug "User Particular: #{@ngo_user.name}"
    @user_particular.update(status: 'verified', verifier_ngo: @ngo_user.name)# Update the status to 'verified'
    flash[:notice] = "Verification successful for unique ID: #{@user_particular.unique_id}."
    redirect_to ngo_user_path(@ngo_user), status: :found
  end
end
