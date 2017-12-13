require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :categories
  resources :home, only: :index

  authenticated :user do
    root 'home#index'
  end
  root 'home#index'
end
