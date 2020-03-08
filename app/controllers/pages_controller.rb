class PagesController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:home]
  skip_after_action :verify_authorized, only: :home

  def home
    @attractions = policy_scope(Attraction).order(created_at: :desc)
  end

  def my_bookings
    @bookings = current_user.bookings #policy_scope(Booking)
    authorize @bookings
  end

  def my_attractions
    @attractions = current_user.attractions
    authorize @attractions
  end

  def profile
    @user = current_user
    authorize @user
  end

  def be_a_guide
    @user = current_user
    @user.guide!
    authorize @user
  end

  def my_personalities
    @personalities = current_user.personalities
    authorize @personalities
  end

end
