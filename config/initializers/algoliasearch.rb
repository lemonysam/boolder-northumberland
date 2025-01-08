Sidekiq.configure_client do |config|
  config.redis = { ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
end

AlgoliaSearch.configuration = { 
  application_id: Rails.application.credentials.dig(:algolia, :app_id),
  api_key: Rails.application.credentials.dig(:algolia, :api_key) 
}