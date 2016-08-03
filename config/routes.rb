Rails.application.routes.draw do
  # mount Sidekiq::Web => '/thatqueuethough'

  # Custom devise controllers for user session management
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  get '/assets' => 'assets#index'

  resources :indices, only: [:new, :create, :show]

  root to: 'home#index'
end
