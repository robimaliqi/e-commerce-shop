class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  after_create_commit do
    broadcast_replace_to cart,
                         target: "cart_count",
                         partial: "cart/item_count",
                         locals: { count: cart.quantity }
  end

  after_update_commit do
    broadcast_replace_to cart,
                         target: "cart_count",
                         partial: "cart/item_count",
                         locals: { count: cart.quantity }
  end

  after_destroy_commit do
    broadcast_remove_to cart
    broadcast_replace_to cart,
                         target: "cart_count",
                         partial: "cart/item_count",
                         locals: { count: cart.quantity }
  end
end
