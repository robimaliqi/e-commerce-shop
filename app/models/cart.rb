class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  enum status: {
    checkout_pending: 0,
    payment_pending: 1,
    payment_complete: 2,
    fullfilled: 3,
    cancelled: 4
  }

  def quantity
    cart_items.sum(&:quantity)
  end
end
