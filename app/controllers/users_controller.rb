class UsersController < ApplicationController
  def update_to_guide
    acts_as_voter
    @user = current_user
    @user.guide!
    authorize @user
    redirect_to profile_path
  end
end
