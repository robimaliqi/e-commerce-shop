class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_cart
    cart = Cart.find_or_create_by(user: current_user)
    cookies[:cart_token] ||= cart.token
    cart
  end
  helper_method :current_cart
end
