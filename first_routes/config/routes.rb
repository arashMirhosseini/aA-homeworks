Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'users', to: 'users#index', as: 'users'
  # post 'users', to: 'users#create'
  # get 'users/new', to: 'users#new', as: 'new_user'
  # get 'users/:id/edit', to: 'users#edit', as: 'edit_users'
  # get 'users/:id', to: 'users#show', as: 'user'
  # patch 'users/:id', to: 'users#update'
  # put 'users/:id', to: 'users#update'
  # delete 'users/:id', to: 'users#destroy'

  resources :users, only: [:index, :create, :destroy, :show, :update] do
    resources :artworks, only: [:index]
  end

  # resources :users, only: [:create, :destroy, :show, :update]

  resources :artworks, only: [:index, :create, :destroy, :show, :update]

  resources :artwork_shares, only: [:create, :destroy]

  resources :comments, only: [:index, :create, :destroy]



end
