class PaymentsController < ApplicationController
  def show
    current_cart&.payment_pending! unless current_cart&.checkout_pending?
    cookies.delete(:cart_token)
  end
end
