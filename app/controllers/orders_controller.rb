class OrdersController < ApplicationController
 skip_after_action :verify_authorized

  def create
    tour = Tour.find(params[:tour_id])
    order  = Order.create!(tour: tour, tour_sku: tour.sku, amount: tour.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: tour.name,
        amount: tour.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)

    redirect_to new_order_payment_path(order)

  end

  def show
    @order = current_user.orders.find(params[:id])
  end

end
