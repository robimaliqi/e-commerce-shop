class PaymentsController < ApplicationController
  def show
    current_cart&.payment_pending!
    current_user.cart.cart_items.destroy_all if current_user&.cart
    cookies.delete(:cart_token)
  end
end
