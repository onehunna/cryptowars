Rails.application.routes.draw do
  # mount Sidekiq::Web => '/thatqueuethough'

  # Custom devise controllers for user session management
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  get '/assets' => 'assets#index'

  root to: 'home#index'
  get '/new' => 'indices#new'
  get '/show' => 'indices#show'
end
