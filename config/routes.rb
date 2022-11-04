Rails.application.routes.draw do
  devise_for :users
  root "posts#index" 

  resources :users
  
  resources :posts, only: [:index, :show] do
    collection do
      get "sort", to: "posts#index"
    end
  end
    resources :posts, except: [:index, :show] do
      resources :comments, except: [:show] do
        collection do
          get "sort", to: "comments#index", as: :sort
        end
        member do
          post "like", to: "comments#like"
          post "unlike", to: "comments#unlike"
        end
      end
    end

  resources :posts, except: [:index, :show] do
    member do
      post "like", to: "posts#like"
      post "unlike", to: "posts#unlike"
    end
  end

  resources :tags, only: [:show] do
    resources :posts, only: [:index] do
      collection do
        get "sort", to: "posts#tag_index", as: :sort
      end
    end
  end

  namespace :admin do
    root "application#index"
  end
end
