class AttractionsController < ApplicationController
before_action :set_attraction, only: [ :edit, :update, :destroy]

  def index
     @attractions =  Attraction.all
    if params[:search].present? && params[:search][:query].present?
      @attractions = policy_scope(Attraction).where("address ILIKE '%#{params[:search][:query]}%'").geocoded
    else
      @attractions = policy_scope(Attraction).order(created_at: :desc).geocoded
    end

    @markers = @attractions.map do |attraction|
      {
        lat: attraction.latitude,
        lng: attraction.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { attraction: attraction })
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
    params.require(:attraction).permit(:name, :address, :description, :user_id, photos: [])
  end
end

def set_attraction
    @attraction = Attraction.find(params[:id])
end
