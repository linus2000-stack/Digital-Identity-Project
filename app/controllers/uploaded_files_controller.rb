class UploadedFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_particular

  def create
    uploaded_file = params[:uploaded_file][:file_path]
    name = uploaded_file.original_filename
    file_path = Rails.root.join('public', 'uploads', SecureRandom.uuid, name)  # Example path, adjust as needed
    file_type = uploaded_file.content_type
    file_size = uploaded_file.size

    # Save file to storage (local or cloud)
    FileUtils.mkdir_p(File.dirname(file_path))
    File.open(file_path, 'wb') do |file|
      file.write(uploaded_file.read)
    end

    # Save file metadata to database
    @user_particular.uploaded_files.create!(
      name: name,
      file_path: file_path.to_s,
      file_type: file_type,
      file_size: file_size
    )

    render json: { success: true, file: { name: name, path: file_path.to_s, type: file_type, size: file_size } }, status: :created
  end

  def index
    files = @user_particular.uploaded_files
    render json: files
  end

  def destroy
    file = @user_particular.uploaded_files.find(params[:id])
    File.delete(file.file_path) if File.exist?(file.file_path)
    file.destroy
    render json: { success: true }
  end

  private

  def set_user_particular
    @user_particular = current_user.user_particular
  end
end
