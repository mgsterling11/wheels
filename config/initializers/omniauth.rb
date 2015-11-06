Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {:scope => 'email, profile'}
  provider :uber, ENV['UBER_APP_ID'], ENV['UBER_APP_SECRET'], :scope => 'profile'
end