Rails.application.routes.draw do

  resources :topics
  scope :api do
    scope :v1 do

      resources :systems

      resources :devices, except: [:destroy] do
        resources :subscriptions, except: [:update], module: 'devices'
        resources :notifications, only: [:create]
      end

      resources :topics, except: [:destroy] do
        resources :notifications, only: [:create]
      end

      resources :tags
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
