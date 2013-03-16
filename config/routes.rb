Kitten::Application.routes.draw do
  # login & logout
  get 'login' => 'sessions#new', :as => :login
  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

  # a way to get some user data for the mta server
  post 'mta-auth' => 'sessions#auth'

  # allow new people to register
  get 'signup' => 'users#new', :as => :signup
  post 'signup' => 'users#create'
  
  # user list
  resources :users, :only => [:show]

  resources :blogs, :path => '/blog' do
    post :comment

    # all not-post requests on comments are redirected to the blog post
    match 'comment' => redirect('/blog/%{blog_id}')
  end

  resources :forums, :only => [:index], :path => '/community'

  # root
  root :to => 'sessions#new'
end
