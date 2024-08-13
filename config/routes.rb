Rails.application.routes.draw do  

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show create update destroy]
      resources :contracts
      resources :companies
      resources :schedules
      resources :shifts
      
      post '/signin', to: 'auth#signin'
      post '/signup', to: 'auth#signup'
      get '/confirmed', to: 'shifts#confirmed'
      get '/weeks', to: 'shifts#weeks'
    end
  end
end
