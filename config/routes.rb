Rails.application.routes.draw do
  resources :follows
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end
  root "posts#index" 

  resources :users

  resources :users, only: [:show] do
    member do
      get "comments", to: "users#comments"
      get "replies", to: "users#replies"
    end
  end

  resources :posts, only: [:new]
  
  resources :posts, only: [:index] do
    collection do
      get "sort", to: "posts#index"
    end
  end

  resources :posts, only: [:show] do
    member do
      get "like", to: "posts#like"
      get "unlike", to: "posts#unlike"
      get "image", to: "posts#image"
    end
  end
    resources :posts, except: [:index, :show] do
      resources :comments, except: [:show] do
        collection do
          get "sort", to: "comments#index", as: :sort
        end
        member do
          get "like", to: "comments#like"
          get "unlike", to: "comments#unlike"
        end
      end
    end

  resources :tags do
    member do
      get "follow", to: "tags#follow", as: "follow"
      get "unfollow", to: "tags#unfollow", as: "unfollow"
    end
  end

  resources :tags, only: [:show] do
    collection do
      get "/search", to: "tags#show"
    end
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
