class AttractionsController < ApplicationController
  before_action :set_attraction, only: [ :edit, :update, :destroy]

  def index
     #@attractions =  Attraction.all
    if params[:search].present? && params[:search][:query].present?
      @attractions = policy_scope(Attraction).where("address ILIKE '%#{params[:search][:query]}%'").geocoded
      @attractions_name = policy_scope(Attraction).where("name ILIKE '%#{params[:search][:query]}%'").geocoded
      @attractions += @attractions_name
      @attractions.uniq!
    else
      @attractions = policy_scope(Attraction).order(created_at: :desc).geocoded
    end
    #  @attractions =  Attraction.all
    # if params[:search].present? && params[:search][:query].present?
    #   @attractions = policy_scope(Attraction).where("address ILIKE '%#{params[:search][:query]}%'").geocoded.or(policy_scope(Attraction).where("name ILIKE '%#{params[:search][:query]}%'"))
    # end

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
    @attraction.country = Geocoder.search(attraction_params[:address]).first.country
    authorize @attraction

    if @attraction.save!
      redirect_to attractions_path
    else
      render_errors
    end
  end

  def edit
    authorize @attraction
  end

  def update
    authorize @attraction
    if @attraction.update(attraction_params)
      @attraction.save
      redirect_to attraction_path
    else
      puts @attraction.errors.messages
      render :edit
    end
  end

  def destroy
    authorize @attraction
  if @attraction.destroy
      redirect_to my_attractions_path, notice: "Attraction was successfully destroyed"
  else
      puts @attraction.errors.messages
    end
  end


  private

  def attraction_params
    params.require(:attraction).permit(:name, :address, :description, :user_id, :country, photos: [])
  end
end

def set_attraction
    @attraction = Attraction.find(params[:id])
end
