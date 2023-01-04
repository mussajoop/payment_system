require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  authenticated :user do
    root to: "transactions#index", as: :authenticated_user
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :transactions do
    post :payment, on: :collection
  end

  resources :merchants
end
