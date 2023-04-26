Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      post "/road_trip", to: "road_trip#create"
      resources :forecast, only: [:index]
      resources :users, only: [:create]
      resources :sessions, only: [:create]
    end
  end
end
