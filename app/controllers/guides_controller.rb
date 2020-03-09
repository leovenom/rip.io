class GuidesController < ApplicationController
 before_action :set_guide, only: :show

  def index
    @guides = policy_scope(User).where(role: 'guide')
  end

  def show
#    @guide = policy_scope(User).find(params[:id])
    authorize @guide
  end

  private

  def guide_params
    params.require(:user).permit(:email, :first_name, :last_name, :profile_picture, :role)
  end

  def set_guide
    @guide = User.find(params[:id])
  end
end
