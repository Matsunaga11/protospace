Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :prototypes do
    resources :comments, only: [:create, :destroy, :edit, :update]
    resources :likes, only: [:create, :destroy]

    collection do
      get 'index_popular'
    end
  end

  resources :users, only: [:show, :edit, :update]

end
