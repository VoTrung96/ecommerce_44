Rails.application.routes.draw do
  root "static_pages#home"
  get "/contact", to: "contact#new"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :products, only: [:index, :show]
  resources :categories, only: :show
end
