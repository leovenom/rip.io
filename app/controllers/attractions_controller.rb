class AttractionsController < ApplicationController
  before_action :set_attraction, only: [ :edit, :update, :destroy, :upvote, :downvote]
  before_action :check_if_guide, only: [:new, :create, :edit, :update]

  def index
    if params[:search].present? && params[:search][:query].present?
      @attractions = policy_scope(Attraction).where("address ILIKE '%#{params[:search][:query]}%'").geocoded
      @attractions_name = policy_scope(Attraction).where("name ILIKE '%#{params[:search][:query]}%'").geocoded
      @attractions_country = policy_scope(Attraction).where("country ILIKE '%#{params[:search][:query]}%'").geocoded
      @attractions = @attractions_name + @attractions_country + @attractions
      @attractions.uniq!
    elsif params[:chosen] == "personalities"
      @attractions = []
    else
      @attractions = policy_scope(Attraction).order(created_at: :desc).geocoded
    end
    if params[:search].present? && params[:search][:query].present?
      @personalities = policy_scope(Personality).where("address ILIKE '%#{params[:search][:query]}%'")
      @personalities_name = policy_scope(Personality).where("name ILIKE '%#{params[:search][:query]}%'")
      @personalities += @personalities_name
      @personalities.uniq!
    elsif params[:chosen] == "attractions"
      @personalities = []
    else
      @personalities = policy_scope(Personality).order(created_at: :desc).geocoded
    end
    #  @attractions =  Attraction.all
    # if params[:search].present? && params[:search][:query].present?
    #   @attractions = policy_scope(Attraction).where("address ILIKE '%#{params[:search][:query]}%'").geocoded.or(policy_scope(Attraction).where("name ILIKE '%#{params[:search][:query]}%'"))
    # end
    @markers = @attractions.map do |attraction|
      {
        lat: attraction.latitude,
        lng: attraction.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { attraction: attraction }),
        image_url: helpers.asset_url('rip-round-blue-50px.svg')
      }
    end

    @personality_markers = @personalities.map do |personality|
      {
        lat: personality.latitude,
        lng: personality.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { personality: personality }),
        image_url: helpers.asset_url('death-round-blue-50px.svg')
      }
    end
    @markers += @personality_markers
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
      byebug
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

  #upvote_from_user
  def upvote
    @attraction.upvote_from current_user
    redirect_to attractions_path
  end

  #downvote_from_user
  def downvote
    @attraction.downvote_from current_user
    redirect_to attractions_path
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :address, :description, :user_id, :text, :country, photos: [], tour_ids: [])
  end

  def set_attraction
      @attraction = Attraction.find(params[:id])
  end

  def check_if_guide
    redirect_to root_path, notice: "You have to be a guide to create a tour" unless current_user.role == "guide"
  end
end
