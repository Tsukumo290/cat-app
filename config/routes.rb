Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :users, only: [:show, :edit, :update]
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  get "search_post", to: "posts#search_post"
end
