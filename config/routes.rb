Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  devise_for :users

  root "products#index"

  get :about, to: "main#about"

  get  "/contact", to: "contact#new"
  post "/contact", to: "contact#create"
  get  "/contact/success", to: "contact#success"

  resources :products, only: %i[index show]
  resources :line_items, only: %i[create update destroy]
  resources :orders, except: :index
  resource  :cart, only: %i[show destroy]

  namespace :admin do
    resources :carts, only: %i[index show]
    resources :line_items, only: %i[index show]
    resources :orders
    resources :products
    resources :users

    root to: "products#index"
  end
end
