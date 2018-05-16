Rails.application.routes.draw do
  root "static_pages#home"
  get "/contact", to: "contact#new"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "/signup", to: "users#create"
  post "/add", to: "carts#add", as: :add
  patch "/change", to: "carts#change", as: :change
  delete "/remove/:id", to: "carts#remove", as: :remove
  get "/checkout", to: "orders#new"
  post "/checkout", to: "orders#create"
  resources :products, only: [:index, :show]
  resources :categories, only: :show
  resources :users, expect: [:index, :show, :destroy]
  resources :carts, only: :index
  resources :orders, only: [:index, :show, :update]
  resources :comments, only: :create
  resources :ratings, only: :create
  namespace :admin do
    resources :categories, expect: :show
    resources :products, expect: :show
  end
end
