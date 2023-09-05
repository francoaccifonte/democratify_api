Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_DSN', nil)
  # config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.enabled_environments = %w[production]
  config.send_default_pii = true

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  # config.traces_sampler = lambda do |context|
  #   true
  # end

  ignored_exceptions = [Puma::HttpParserError]
  config.before_send = lambda do |event, hint|
    # NOTE: hint[:exception] would be a String if you use async callback
    if ignored_exceptions.any? { |ex| hint[:exception].is_a?(ex) }
      nil
    else
      event
    end
  rescue StandardError => e
    e
  end
end
