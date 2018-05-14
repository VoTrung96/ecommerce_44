Rails.application.routes.draw do
  root "static_pages#home"
  get "/contact", to: "contact#new"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "/signup", to: "users#create"
  patch "/change", to: "carts#change", as: :change
  delete "/remove/:id", to: "carts#remove", as: :remove
  get "/checkout", to: "carts#checkout", as: :checkout
  post "/add", to: "carts#add", as: :add
  resources :products, only: [:index, :show]
  resources :categories, only: :show
  resources :users
  resources :carts, only: :index
end
