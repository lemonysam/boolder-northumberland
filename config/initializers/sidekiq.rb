Sidekiq.configure_client do |config|
    config.redis = { ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
end
  