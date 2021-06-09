if Rails.env.development?
    Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://localhost:6379/0' }
    end

    Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://localhost:6379/0' }
    end
    end

    if Rails.env.production?
    Sidekiq.configure_client do |config|
    config.redis = { url: ENV.fetch('REDIS_URL'), size: 1, network_timeout: 5 }
    end

    Sidekiq.configure_server do |config|
    config.redis = { url: ENV.fetch('REDIS_URL'), size: 12, network_timeout: 5 }
    end

    Sidekiq::Extensions.enable_delay!
end