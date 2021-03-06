Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  resources :microposts,    only: [:new, :create, :destroy]
  get "index" => "top#index"

  namespace :api do
    get "index" => "top#index"
    resources :users, only: [:index, :show]
    resources :microposts,    only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy]
  end
end
