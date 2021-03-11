Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [] do
        resources :favorites, only: [:index, :create, :destroy]
      end
      
      resources :houses, only: [:index, :create]
      resources :tokens, only: [:create]

      post '/auth/login', to: 'authentications#create'
    end
  end
end
