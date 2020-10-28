Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :comments, only: :create
    collection do
      get 'search'
      get 'search_tag'
    end
  end
end
