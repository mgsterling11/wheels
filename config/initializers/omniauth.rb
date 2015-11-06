Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']
  provider :uber, ENV['UBER_APP_ID'], ENV['UBER_APP_SECRET']
end