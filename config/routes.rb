Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :companies, only: [:show, :new, :create] do
    resources :footprints, only: [:new, :create, :update, :download]
  end
end
