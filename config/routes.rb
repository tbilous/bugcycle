Rails.application.routes.draw do
  devise_for :users

  get '/search', to: 'searches#search'

  resources :black_lists, only: %i(create destroy)

  resources :categories do
    resources :items, shallow: true do
      resources :suggestions, only: %i(create update destroy edit), shallow: true do
        put :apply, to: 'suggestions#apply'
      end
    end
  end
  resources :home, only: :index

  authenticated :user do
    root 'home#index'
  end
  root 'home#index'
end
