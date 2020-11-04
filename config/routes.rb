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

  resources :users, only: :show

  post 'follow/:id', to: 'relationships#follow', as: 'follow'
  post 'unfollow/:id', to: 'relationships#unfollow', as: 'unfollow'
  get 'users/following/:user_id', to: 'users#following', as: 'users_following'
  get 'users/follower/:user_id', to: 'users#follower', as: 'users_follower'

end
