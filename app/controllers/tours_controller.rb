class ToursController < ApplicationController
 before_action :set_tour, only: [:show, :update, :edit, :destroy]

  def index
     @tour = Tour.all
     @tour = policy_scope(Tour).order(created_at: :desc)
  end

  def show
    authorize @tour
  end

  def new
    @tour = Tour.new
    authorize @tour
  end

  def create
    @tour = Tour.new(tour_params)
    if current_user.role == "guide"
      @tour.user = current_user
      authorize @tour
    else
      puts "You have to be a guide to create a tour"
    end

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

  def tour_params
    params.require(:tour).permit(:price)
  end

  def set_tour
    @tour = Tour.find(params[:id])
  end
end
