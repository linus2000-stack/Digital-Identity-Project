class SavedPostsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    # Permit the parameters
    permitted_params = params.permit(:user_id, :bulletinId)
    logger.debug "PERMITTED PARAMS: #{permitted_params[:bulletinId].inspect}, #{permitted_params[:user_id].inspect}"
    @saved_post = SavedPost.find_by(bulletin_id: permitted_params[:bulletinId], user_id: permitted_params[:user_id])
    logger.debug "SAVED POST: #{@saved_post.inspect}"

    if @saved_post
      @saved_post.destroy
      render json: { success: true }
    else
      render json: { success: false, error: 'Post not found' }, status: :not_found
    end
  end

  def create
    bulletin = Bulletin.find(params[:bulletin_id])
    saved_post = current_user.saved_posts.find_by(bulletin_id: bulletin.id)
    logger.debug "SAVED POST: #{saved_post.inspect}"

    if saved_post.nil?
      saved_post = current_user.saved_posts.create(
        bulletin_id: bulletin.id,
        title: bulletin.title,
        date: bulletin.date,
        location: bulletin.location,
        description: bulletin.description,
        ngo_name: bulletin.ngo_name,
        saved: true
      )

      if saved_post.save
        puts "Saved post: #{saved_post.inspect}"
        render json: { success: true, action: 'saved' }
      else
        render json: { success: false }
      end
    else
      saved_post.destroy
      render json: { success: true, action: 'unsaved' }
    end
  end
end
