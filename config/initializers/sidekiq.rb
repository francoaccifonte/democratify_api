# frozen_string_literal: true

REDIS_HOSTNAME = ENV.fetch('REDIS_HOSTNAME', 'localhost')
REDIS_PORT = ENV.fetch('REDIS_PORT', 6379)
REDIS_URL = "redis://#{REDIS_HOSTNAME}:#{REDIS_PORT}".freeze
CACHE_EXPIRES_HOURS = ENV.fetch('CACHE_EXPIRES_HOURS', 24).to_i

puts REDIS_URL
Sidekiq.configure_server do |config|
  config.redis = { url: REDIS_URL }
end

Sidekiq.configure_client do |config|
  config.redis = { url: REDIS_URL }
end
