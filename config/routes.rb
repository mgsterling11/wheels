Rails.application.routes.draw do
  resources :user_trips, except: :new
  root to: 'user_trips#new'
  post '/user_trip' => 'user_trips#create', :as => :new_user_trip

  #login routes
  get '/facebook_login', to: redirect('/auth/facebook')
  get '/uber_login', to: redirect('/auth/uber')
  get '/auth/:provider/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy', :as => :logout
  get '/user_trips/:id/taxi_data' => 'user_trips#taxi_data', :as => :taxi_data
  get '/user_trips/:id/subway_directions' => 'user_trips#subway', :as => :subway
  get 'users/:id/my_trips' => 'users#show', :as => :my_trips

end
