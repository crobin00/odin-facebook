Rails.application.routes.draw do
  root "posts#index"
  resources :posts do
    resources :likes
    resources :comments
  end
  devise_for :users
end
