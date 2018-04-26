Rails.application.routes.draw do
  root "static_pages#home"
  get "/contact", to: "contact#new"
  resources :products, only: [:index, :show]
  resources :categories, only: :show
end
