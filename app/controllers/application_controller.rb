class ApplicationController < ActionController::Base

  def current_cart
    if user_signed_in?
      cart = Cart.find_or_create_by(user: current_user)
    else
      cart = Cart.find_or_create_by(token: cookies[:cart_token])
    end
  
    cookies[:cart_token] ||= cart.token
    cart
  end
  helper_method :current_cart
end
