Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  get 'posts/show'
  get 'posts/new'
  get 'posts/create'
  get 'posts/destroy'
  get 'show/new'
  get 'show/create'
  get 'show/destroy'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destory'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  get 'users/edit'
  get 'users/update'
  get 'toppages/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get :followings
      get :followers
    end
  end
  
  resources :posts, only: [:show, :new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]



end
