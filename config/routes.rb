Kitten::Application.routes.draw do
  # login & logout
  get 'login' => 'sessions#new', :as => :login
  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

  # a way to get some user data for the mta server
  post 'auth' => 'sessions#auth'

  # allow new people to register
  get 'signup' => 'users#new', :as => :signup
  post 'signup' => 'users#create'

  # user list
  resources :users, :only => [:show]

  resources :blogs, :path => '/blog', :constraints => { :blog_id => /\d[^\/]+/ } do
    post :comment
    constraints :comment_id => /[\d]+/ do
      get ':comment_id' => 'blogs#edit_comment', :as => 'edit_comment'
      put ':comment_id' => 'blogs#update_comment'
    end

    get 'page/:page', :on => :collection, :action => :index
    get 'page/:page', :on => :member, :action => :show

    # all not-post requests on comments are redirected to the blog post
    match 'comment' => redirect('/blog/%{blog_id}')
  end

  resources :forums, :only => [:index, :show], :path => '/community' do
    get 'page/:page', :on => :member, :action => :show
    collection do
      get :manage
      post :managed, :path => 'manage'
    end

    resources :topics, :only => [ :new, :create], :path => '/topic'
    constraints :id => /\d[^\/]+/ do
      get '/:id' => 'topics#show', :as => 'topic'
      get '/:id/page/:page' => 'topics#show'
      post '/:id' => 'topics#reply', :as => 'reply'
    end
  end

  # root
  root :to => 'sessions#new'
end
