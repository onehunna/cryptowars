Rails.application.routes.draw do
  # mount Sidekiq::Web => '/thatqueuethough'

  # Custom devise controllers for user session management
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    delete '/sign-out' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  get '/assets' => 'assets#index'
  get '/roll-dice' => 'assets#roll_dice'

  resources :indices, only: [:new, :create, :show, :destroy]

  root to: 'home#index'
end
