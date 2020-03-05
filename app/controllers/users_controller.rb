class UsersController < ApplicationController
  def update_to_guide
    @user = current_user
    @user.guide!
    authorize @user
    redirect_to profile_path
  end
end
