module Webhooks
  class Checkout
    def initialize(event)
      @event = event
    end

    def call
      cart = Cart.find_by!(stripe_session_id: object.id)
      cart.payment_complete!
      
    end

    private

    def object
      @event.data.object
    end

  end
end 