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
      @personalities += @personalities_name
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
        lng: personality.longitude
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

    def personality_params
    params.require(:personality).permit(:name, :address, :description, :user_id, photos: [])
  end


def set_personality
    @personality = Personality.find(params[:id])
end

end
