class ReviewsController < ApplicationController
  before_action :find_tour

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.tour_id = @tour.id
    @review.user_id = current_user.id

    if @review.save
      redirect_to tour_path(@tour)
    else
      render 'new'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def find_tour
    @tour = Tour.find(params[:tour_id])
  end
end
