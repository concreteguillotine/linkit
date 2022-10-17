Rails.application.routes.draw do
  devise_for :users
  root "posts#index" 

  resources :posts, only: [:index, :show] do
    resources :comments, only: [:index, :show]
  end

  resources :users do
    resources :comments, except: [:index, :show]
  end

    resources :posts, except: [:index, :show] do
      resources :comments, except: [:index, :show]
      member do
        post "like", to: "posts#like"
        post "unlike", to: "posts#unlike"
      end
    end

  namespace :admin do
    root "application#index"

    resources :posts, except: [:index, :show] 
  end
end
