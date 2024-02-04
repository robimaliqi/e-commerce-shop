class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def create
    session = Stripe::Checout::Session.create(
      billing_address_collection: :auto,
      mode: :payment,
      payment_method_types: ['card'],
      line_items: ,
      success_url: checkout_payment_url,
      cancel_url: root_url
    )

    current_cart.update!(stripe_session_id: session.id)
    redirect_to session.url, allow_other_host: true
  end

  private

  def cart_items
    current_cart.cart_items.map do |cart_item|
      {
        price_data: {
          currency: "gbp",
          product_data: {
            name: cart_item.product.name
          },
          unit_amount: cart_item.product.price.to_i * 100
        },
        quantity: cart_item.quantity
      }
    end 
  end
end
