class ApplicationController < ActionController::Base
  def current_cart
    if user_signed_in?
      cart = Cart.find_or_create_by(user: current_user)
    else
      token = cookies[:cart_token] || SecureRandom.alphanumeric(10)
      cookies[:cart_token] ||= token
      cart = Cart.find_or_create_by(token: token)
    end
    transfer_items_from_temp_cart(cart)
    cart
  end
  
  helper_method :current_cart

  def after_sign_out_path_for(resource)
    root_path
  end

  private

  def transfer_items_from_temp_cart(user_cart)
    if cookies[:cart_token].present?
      temp_cart = Cart.find_by(token: cookies[:cart_token])
      if temp_cart.present? && temp_cart != user_cart
        temp_cart.cart_items.update_all(cart_id: user_cart.id)
        temp_cart.destroy
        cookies.delete(:cart_token)
      end
    end
  end
end
