Sentry.init do |config|
  config.dsn = "https://sohE2oZgNdE39hj4Lv3Rarjy@s1674201.eu-nbg-2.betterstackdata.com/1674201"
  config.breadcrumbs_logger = [ :active_support_logger, :http_logger ]
  config.traces_sample_rate = 1.0
  config.environment = Rails.env
  config.enabled_environments = %w[production staging development]

  # Disable SSL verification for local development (to avoid certificate verification issues)
  config.transport.ssl_verification = !Rails.env.development?
end
