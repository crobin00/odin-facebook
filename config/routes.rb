Rails.application.routes.draw do
  root "posts#index"
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  devise_for :users
  resources :users, only: [:index, :show]
  resources :notifications
  resources :friend_requests, only: [:create, :update, :destroy]
  resources :friends, only: [:index, :create, :destroy]
end
