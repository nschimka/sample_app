Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root 'static_pages#home'
  get '/pricing', to: 'static_pages#pricing'
  get '/signup', to: 'users#new'
  get '/about', to: 'static_pages#about'
  get '/resend_activation', to: 'users#new_activation'
  post '/resend_activation', to: 'users#resend_activation'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :subscriptions do
    member do
      get :cancel
      get :update_payment
      get :change_plan
    end
  end
end
