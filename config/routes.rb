Rails.application.routes.draw do
  devise_for :users, controllers: {
    # omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end


  root to: "items#index"
  resources :items do
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
    collection do
      get 'search'
      get 'search_tag'
    end
  end

  resources :users, only: :show do
    member do
      get :followings, :followers
    end
  end
  resources :follow_relationships, only: [:create, :destroy]
end
