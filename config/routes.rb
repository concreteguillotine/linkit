Rails.application.routes.draw do
  devise_for :users
  root "posts#index" 

  resources :users do
    resources :comments, except: [:index, :show]
  end

    resources :posts, except: [:index, :show] do
      delete "tags/remove/:id", to: "tags#remove", as: :remove_tag
      resources :comments, except: [:index, :show]
      member do
        post "like", to: "posts#like"
        post "unlike", to: "posts#unlike"
      end
    end

    resources :posts, only: [:index, :show] do
      resources :comments, only: [:index, :show] do
          post "like", to: "comments#like"
          post "unlike", to: "comments#unlike"
      end
    end  

    resources :tags, only: [:show] do
      collection do
        get ":id", to: "tags#show", as: :show
      end
    end

    resources :comments do
      post "like", to: "comments#like"
      post "unlike", to: "comments#unlike"
    end

  namespace :admin do
    root "application#index"
  end
end
