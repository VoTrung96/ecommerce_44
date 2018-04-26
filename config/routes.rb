Rails.application.routes.draw do
  root "static_pages#home"
  get "/contact", to: "contact#new"
  get "/signup", to: "users#new"
  post "/signup",  to: "users#create"
  resources :users, only: [:new, :create]
  resources :products, only: [:index, :show]
  resources :categories, only: :show
end
