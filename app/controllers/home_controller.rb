class HomeController < ApplicationController
  def index
    # Fetch any necessary data for the home page
    @user = current_user
    # Render home page
  end
end
