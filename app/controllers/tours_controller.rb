class ToursController < ApplicationController
 before_action :set_tour, only: [:show, :update, :edit, :destroy]
 before_action :check_if_guide, only: [:new, :create, :edit, :update]

  def index
    @tours = Tour.all
    @tours = policy_scope(Tour).order(created_at: :desc)
  end

  def show
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
      puts @tour.errors.messages
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
        redirect_to tour_path
      else
        puts @tour.errors.messages
        render :edit
      end
  end

  def destroy
    @tour = Tour.where(user_id: current_user.id).first
    authorize @tour
    @tour.destroy
    redirect_to root_path
  end

private

  def check_if_guide
    redirect_to root_path, notice: "You have to be a guide to create a tour" unless current_user.role == "guide"
  end

  def tour_params
    params.require(:tour).permit(:price, :name, :description)
  end

  def set_tour
    @tour = Tour.find(params[:id])
  end
end
