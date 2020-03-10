class PersonalitiesController < ApplicationController
before_action :set_personality, only: [ :edit, :update, :destroy]

  def new
    @personality = Personality.new
    authorize @personality
  end

  def index
      if params[:search].present? && params[:search][:query].present?
      @personalities = policy_scope(Personality).where("address ILIKE '%#{params[:search][:query]}%'").geocoded
      @personalities_name = policy_scope(Personality).where("name ILIKE '%#{params[:search][:query]}%'").geocoded
      @personalities_country = policy_scope(Personality).where("country ILIKE '%#{params[:search][:query]}%'").geocoded
      @personalities = @personalities_name + @personalities_country + @personalities
      @personalities.uniq!
    else
      @personalities = policy_scope(Personality).order(created_at: :desc).geocoded
    end
    #  @personalities =  Personality.all
    # if params[:search].present? && params[:search][:query].present?
    #   @personalities = policy_scope(Personality).where("address ILIKE '%#{params[:search][:query]}%'").geocoded.or(policy_scope(Personality).where("name ILIKE '%#{params[:search][:query]}%'"))
    # end

    @markers = @personalities.map do |personality|
      {
        lat: personality.latitude,
        lng: personality.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { personality: personality })

      }
    end
  end

  def show
    @personality = Personality.find(params[:id])
    authorize @personality
  end

  def create
    @personality = Personality.new(personality_params)
    @personality.user = current_user
    # @personality.country = Geocoder.search(personality_params[:address]).first.country

    authorize @personality

    if @personality.save!
      redirect_to personality_path(@personality)
    else
      render_errors
    end
  end

    def edit
    authorize @personality
  end

  def update
    authorize @personality
    if @personality.update(personality_params)
      @personality.save
      redirect_to personality_path
    else
      puts @personality.errors.messages
      render :edit
    end
  end

  def destroy
    authorize @personality
  if @personality.destroy
      redirect_to my_personalities_path, notice: "Personality was successfully destroyed"

  else
      puts @personality.errors.messages
    end
  end

  private

    def personality_params
    params.require(:personality).permit(:name, :address, :description, :text, :user_id, :country, photos: [])
  end


def set_personality
    @personality = Personality.find(params[:id])
end

end
