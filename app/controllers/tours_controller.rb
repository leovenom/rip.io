class ToursController < ApplicationController
 before_action :set_tour, only: [:show, :update, :edit, :destroy]
 before_action :check_if_guide, only: [:new, :create, :edit, :update]

  def index
    @tours = Tour.all
    @tours = policy_scope(Tour).order(created_at: :desc)
  end

  def show
    @tour = Tour.find(params[:id])
    @booking = Booking.new
    authorize @tour
  end

  def new
    @tour = Tour.new
    @attraction = Attraction.find(params[:attraction_id])
    @guide = current_user
    authorize @tour
  end

  def create
    @tour = Tour.new(tour_params)
    @attraction = Attraction.find(params[:attraction_id])
    @tour.guide = current_user

    authorize @tour
    if @tour.save
      redirect_to root_path, notice: 'Tour was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @tour
  end

  def update
    authorize @tour

    if @tour.update(tour_params)
      @tour.save
      redirect_to my_tours_path
    else
      render :edit
    end
  end

  def destroy
    @tour = Tour.find(params[:id])
    authorize @tour
    @tour.destroy
    redirect_to my_tours_path
  end

private

  def check_if_guide
    redirect_to root_path, notice: "You have to be a guide to create a tour" unless current_user.role == "guide"
  end

  def tour_params
    params.require(:tour).permit(:price, :name, :description, attraction_ids: [])
  end

  def set_tour
    @tour = Tour.find(params[:id])
  end
end
