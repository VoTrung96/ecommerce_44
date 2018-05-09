Rails.application.routes.draw do
  delete "/logout", to: "sessions#destroy"
  root "static_pages#home"
  get "/contact", to: "contact#new"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  post "/signup", to: "users#create"
  patch "/change", to: "carts#plus", as: :change
  post "/add", to: "carts#add", as: :add
  resources :products, only: [:index, :show]
  resources :categories, only: :show
  resources :users
end
