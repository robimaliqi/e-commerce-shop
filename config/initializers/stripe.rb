Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

module StripeEvent
  class << self
    attr_accessor :adapter, :backend, :namespace, :event_filter
    attr_reader :signing_secrets

    def configure(&block)
      raise ArgumentError, "must provide a block" unless block_given?
      block.arity.zero? ? instance_eval(&block) : yield(self)
    end
    alias setup configure

    def instrument(event)
      event = event_filter.call(event)
      backend.instrument namespace.call(event.type), event if event
    end

    def subscribe(name, callable = nil, &block)
      callable ||= block
      backend.subscribe namespace.to_regexp(name), adapter.call(callable)
    end

    def all(callable = nil, &block)
      callable ||= block
      subscribe nil, callable
    end

    def listening?(name)
      namespaced_name = namespace.call(name)
      backend.notifier.listening?(namespaced_name)
    end

    def signing_secret=(value)
      @signing_secrets = Array(value).compact
    end
    alias signing_secrets= signing_secret=

    def signing_secret
      signing_secrets && signing_secrets.first
    end
  end

  class Namespace < Struct.new(:value, :delimiter)
    def call(name = nil)
      "#{value}#{delimiter}#{name}"
    end

    def to_regexp(name = nil)
      /^#{Regexp.escape call(name)}/
    end
  end

  class NotificationAdapter < Struct.new(:subscriber)
    def self.call(callable)
      new(callable)
    end

    def call(*args)
      payload = args.last
      subscriber.call(payload)
    end
  end

  class Error < StandardError; end
  class UnauthorizedError < Error; end
  class ProcessError < Error; end

  self.adapter = NotificationAdapter
  self.backend = ActiveSupport::Notifications
  self.namespace = Namespace.new("stripe_event", ".")
  self.event_filter = lambda { |event| event }
end

StripeEvent.signing_secret = Rails.application.credentials.dig(:stripe, :webhook_secret)

StripeEvent.configure do |config|
  config.subscribe "checkout.session.completed" do |event|
    Webhooks::Checkout.new(event).call
  end
end
