Rails.application.routes.draw do
  devise_for :users
  root "posts#index" 

  resources :posts do
    resources :comments
  end

  resources :users do
    resources :comments, except: [:index, :show]
  end

    resources :posts, except: [:index, :show] do
      delete "tags/remove/:id", to: "tags#remove", as: :remove_tag
      resources :comments, except: [:index, :show] do
        post "new", to: "comments#new", as: :new
      end
      member do
        post "like", to: "posts#like"
        post "unlike", to: "posts#unlike"
      end
    end

    resources :posts, only: [:index, :show] do
      collection do
        get "sort", to: "posts#index"
      end
      resources :comments, only: [:index, :show] do
        collection do
          get "sort", to: "comments#index", as: :sort
        end
        post "like", to: "comments#like"
        post "unlike", to: "comments#unlike"
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
