Kitten::Application.routes.draw do
  # login & logout
  get 'login' => 'sessions#new', :as => :login
  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

  # allow new people to register
  get 'signup' => 'users#new', :as => :signup
  post 'signup' => 'users#create'
  
  # user list
  resources :users, :only => [:show]

  resources :blogs, :path => '/blog'

  # root
  root :to => 'sessions#new'
end
