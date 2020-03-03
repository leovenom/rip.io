class PagesController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:home]
  skip_after_action :verify_authorized, only: :home

  def home
  end

  def bookings
    @bookings = current_user.bookings #policy_scope(Booking)
    authorize @bookings
  end

  def profile
    @user = current_user
    authorize @user
  end

end
