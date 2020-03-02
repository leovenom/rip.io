class AttractionsController < ApplicationController

  def index
    @attractions = Attraction.all
  end

  def show
    @attraction = Attraction.find(params[:id])
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.new(attraction_params)

    if @attraction.save
      redirect_to "/attractions"
    else
      render :new
    end
  end

  def attraction_params
    params.require(:attraction).permit(:name, :address, :description)
  end
end
