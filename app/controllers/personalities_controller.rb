class PersonalitiesController < ApplicationController
before_action :set_personality, only: [ :edit, :update, :destroy]

  def new
    @personality = Personality.new
    authorize @personality
  end

  def index
    @personalities =  Personality.all
    if params[:search].present? && params[:search][:query].present?
      @personalities = policy_scope(Personality).where("address ILIKE '%#{params[:search][:query]}%'").geocoded
    else
      @personalities = policy_scope(Personality).order(created_at: :desc).geocoded
    end

    @markers2 = @personalities.map do |personalite|
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

  def destroy
    authorize @personality
  if @personality.destroy
      redirect_to personality_path, notice: "Attraction was successfully destroyed"
  else
      puts @personality.errors.messages
    end
  end

  private

    def personality_params
    params.require(:personality).permit(:name, :address, :description, :user_id, :country, photos: [])
  end


def set_personality
    @personality = Personality.find(params[:id])
end

end
