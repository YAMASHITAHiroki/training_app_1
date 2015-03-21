Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  resources :microposts,    only: [:new, :create, :destroy]
end
