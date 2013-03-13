Kitten::Application.routes.draw do
  # allow new people to register
  get 'signup' => 'users#new', :as => :signup
  post 'signup' => 'users#create'

  # root
  root :to => 'users#new'
end
