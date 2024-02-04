class PaymentsController < ApplicationController
  def show
    @current_cart.payment_pending! unless @current_cart.checkout_pending?
    cookies.delete(:cart_token)
    
    if user_signed_in?
      sign_out(current_user)
      redirect_to root_path, notice: 'Payment successful. You have been signed out.'
    else
      redirect_to root_path, notice: 'Payment successful.'
    end
  end
end