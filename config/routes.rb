Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:create, :show] do
        resources :favorites, only: [:index, :create]
      end
      
      resources :houses, only: [:index, :create]
      resources :tokens, only: [:create]
    end
  end
end
