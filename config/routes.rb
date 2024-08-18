Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show create update destroy]
      resources :contracts
      resources :companies
      resources :schedules
      resources :shifts
      resources :applications, only: %i[create]
      
      post '/signin', to: 'auth#signin'
      post '/signup', to: 'auth#signup'
      get '/check_status', to: 'auth#check_status'
      get '/confirmed/:id', to: 'shifts#confirmed'
      get '/weeks', to: 'shifts#weeks'
      get '/verify_assignment/:id', to: 'shifts#verify_assignment'
    end
  end
end
