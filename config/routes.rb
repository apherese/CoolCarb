Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :companies, only: [:index, :show, :new, :create] do
    resources :footprints, only: [:new, :create]
  end

  resources :footprints, only: [:index, :show, :download] do
    resources :tasks, only: [:new, :create]
  end

  get "dashboard", to: "pages#dashboard"
end
