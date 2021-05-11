Rails.application.routes.draw do
  Healthcheck.routes(self)
  scope :api do
    scope :v1 do
      resources :systems

      resources :devices, except: [:destroy] do
        resources :subscriptions, except: [:update], module: 'devices'
        resources :notifications, only: [:create, :index], module: 'devices'
      end

      resources :topics, except: [:destroy] do
        resources :notifications, only: [:create], module: 'topics'
      end

      resources :tags
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
