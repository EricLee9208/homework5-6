Rails.application.routes.draw do
  # get 'users/new'
  # get 'users/create'
  # get 'users/edit'
  # get 'users/update'
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resource :session, only:[:new, :create, :destroy]

  resources :users, only: [:new, :create, :edit, :update, :show] do
    get "password"
    patch 'password'
  end

  resources :posts do 
    resources :comments, only: [:create, :destroy]
  end

  root "posts#index"
 
  

end
