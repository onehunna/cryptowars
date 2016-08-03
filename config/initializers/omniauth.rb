Rails.application.config.middleware.use OmniAuth::Builder do
  if ENV['TWITTER_CONSUMER_KEY'] && ENV['TWITTER_CONSUMER_SECRET']
    provider :twitter, ENV.fetch('TWITTER_CONSUMER_KEY'), ENV.fetch('TWITTER_CONSUMER_SECRET')
  else
    puts '[WARN] Twitter credentials missing'
  end
end
