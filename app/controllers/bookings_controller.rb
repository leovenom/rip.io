class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    @bookings = policy_scope(Booking).order(created_at: :desc)
  end

  def show
    @booking = Booking.find(booking_params)
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)

    @tour = Tour.find(params[:tour_id])
    @booking.tour = @tour
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to my_bookings_path, notice: 'Booking was successfully created.'
    else
      render :new
      puts @booking.errors.messages
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    @tour = Tour.find(params[:tour_id])
    authorize @booking
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    authorize @booking
    redirect_to my_bookings_path
  end

  def destroy
    @booking = Booking.where(user_id: current_user.id).first
    authorize @booking
    @booking.destroy
    redirect_to my_bookings_destroy_path
  end

  private

  def booking_params
    params.require(:booking).permit(:tour_id, :start_date, :end_date)
  end
end
