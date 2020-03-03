class AttractionsController < ApplicationController


  def index
    @attractions = policy_scope(Attraction)
  end

  def show
    @attraction = Attraction.find(params[:id])
    authorize @attraction
  end

  def new
    @attraction = Attraction.new
    authorize @attraction
  end

  def create
    @attraction = Attraction.new(attraction_params)
    @attraction.user = current_user
    authorize @attraction

    if @attraction.save
      redirect_to "/attractions"
    else
      render_errors
    end
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :address, :description, :user_id)
  end
end
