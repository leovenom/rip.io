class PaymentsController < ApplicationController

  def new
    @order = current_user.orders.where(state: 'pending').find(params[:order_id])
    skip_authorization
  end

end
