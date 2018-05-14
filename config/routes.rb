Rails.application.routes.draw do
  root "static_pages#home"
  get "/contact", to: "contact#new"
  post "/add", to: "carts#add", as: :add
  patch "/change", to: "carts#change", as: :change
  delete "/remove/:id", to: "carts#remove", as: :remove
  get "/checkout", to: "orders#new"
  post "/checkout", to: "orders#create"
  resources :products, only: [:index, :show]
  resources :categories, only: :show
  resources :carts, only: :index
  resources :orders, only: [:index, :show, :update]
  resources :comments, only: :create
  resources :ratings, only: :create
  devise_for :users, :controllers => {registrations: "registrations",
    sessions: "sessions"}
  namespace :admin do
    resources :products, expect: :show
    resources :categories, expect: :show
    resources :orders, expect: [:new, :create, :edit]
    resources :images, only: :destroy
    resources :comments, only: [:index, :destroy]
    post "/comments/delete", to: "comments#delete", as: :delete
    resources :users, expect: :show
  end
end
