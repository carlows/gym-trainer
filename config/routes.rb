Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  get "workouts/new"
  get "workouts/create"
  get "workouts/show"
  resource :chat, only: [ :show, :create ]
  resource :session, only: [ :new, :create, :destroy ]
  resources :workouts, only: [ :new, :create, :show ]

  root "dashboard#index"

  namespace :api do
    namespace :v1 do
      resource :session, only: [ :create, :destroy, :show ]
      resource :chat, only: [ :show, :create ]
      resources :exercises, only: [ :index, :show ]
      resources :routines, only: [ :index, :show ]
      resources :workouts, only: [ :index, :create, :show ]
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
