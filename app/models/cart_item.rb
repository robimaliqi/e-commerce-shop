class CartItem < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :cart
  belongs_to :product

  after_create_commit do
    broadcast_replace_to cart,
                         target: "cart_count",
                         partial: "cart/item_count",
                         locals: { count: cart.quantity }
    broadcast_replace_to cart,
                         target: "total_price",
                         partial: "cart/total_price",
                         locals: { current_cart: cart }
  end

  after_update_commit do
    broadcast_replace_to cart,
                         target: "cart_count",
                         partial: "cart/item_count",
                         locals: { count: cart.quantity }

    broadcast_replace_to cart,
                         target: dom_id(self, "quantity"),
                         partial: "cart/item_quantity",
                         locals: { cart_item: self }
    broadcast_replace_to cart,
                         target: "total_price",
                         partial: "cart/total_price",
                         locals: { current_cart: cart }
  end

  after_destroy_commit do
    broadcast_remove_to cart
    broadcast_replace_to cart,
                         target: "cart_count",
                         partial: "cart/item_count",
                         locals: { count: cart.quantity }
  broadcast_replace_to cart,
                         target: "total_price",
                         partial: "cart/total_price",
                         locals: { current_cart: cart }
  end

  def total_price
    quantity.to_i * product.price.to_f
  end
end
