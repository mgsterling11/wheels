Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']
  provider :uber, ENV['UBER_CLIENT_ID'], ENV['UBER_CLIENT_SECRET']
end