Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://localhost:6379/1') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://localhost:6379/1') }
end

unless Rails.env == 'test'
  require 'sidekiq/api'
  Sidekiq::Queue.all.each &:clear
  Sidekiq::Cron::Job.create(name: 'CleanTransactionsJob - every hour', cron: '0 */1 * * *', class: 'CleanTransactionsJob') unless Rails.env == 'test'
end
