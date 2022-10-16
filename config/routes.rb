Rails.application.routes.draw do
  devise_for :users
  root "posts#index"

  resources :posts, only: [:index, :show] do
    resources :comments, only: [:create]
    member do
      post "like", to: "posts#like"
      post "unlike", to: "posts#unlike"
    end
  end

  namespace :admin do
    root "application#index"

    resources :posts, except: [:index, :show] do
      resources :comments, only: [:destroy]
    end
  end
end
