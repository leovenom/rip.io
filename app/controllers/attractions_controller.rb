class AttractionsController < ApplicationController


  def index
    if params[:search].present? && params[:search][:query].present?
      @attractions = policy_scope(Attraction).where("address ILIKE '%#{params[:search][:query]}%'").geocoded
    else
      @attractions = policy_scope(Attraction).order(created_at: :desc).geocoded
    end

    @markers = @attractions.map do |attraction|
      {
        lat: attraction.latitude,
        lng: attraction.longitude
      }
    end
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
    params.require(:attraction).permit(:name, :address, :description, :user_id, photos: [])
  end
end
