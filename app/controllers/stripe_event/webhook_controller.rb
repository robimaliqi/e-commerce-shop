module StripeEvent
  class WebhookController < ApplicationController
    skip_before_action :verify_authenticity_token

    def event
      StripeEvent.instrument(verified_event)
      head :ok
    rescue Stripe::SignatureVerificationError => e
      log_error(e)
      head :bad_request
    rescue StripeEvent::ProcessError
      head :unprocessable_entity
    end

    private

    def verified_event
      payload          = request.body.read
      signature        = request.headers['Stripe-Signature']
      possible_secrets = secrets(payload, signature)

      possible_secrets.each_with_index do |secret, i|
          return Stripe::Webhook.construct_event(payload, signature, secret.to_s)
      rescue Stripe::SignatureVerificationError
          raise if i == possible_secrets.length - 1
          next
      end
    end

    def secrets(payload, signature)
      return StripeEvent.signing_secrets if StripeEvent.signing_secret
      raise Stripe::SignatureVerificationError.new(
        "Cannot verify signature without a `StripeEvent.signing_secret`",
              signature, http_body: payload
      )
    end

    def log_error(e)
      logger.error e.message
      e.backtrace.each { |line| logger.error "  #{line}" }
    end
  end
end
