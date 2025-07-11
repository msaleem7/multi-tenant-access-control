Rails.application.routes.draw do
  devise_for :users

  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path goes to organisations index
  root "organisations#index"

  # Main resources
  resources :organisations, only: [:index, :show, :create, :destroy] do
    resources :spaces, shallow: true do
      resources :user_spaces, only: [:create], shallow: true
    end
    resources :memberships, shallow: true
  end
end
