TripTracker::Application.routes.draw do
  get "welcome/index"

  controller :sessions do
    get 'login' => :new
    post 'login' => :create 
    delete 'logout' => :destroy
  end

get 'admin' => 'admin#index'
get 'logout' => 'sessions#destroy'

  resources :places do
    collection do
      get 'by_name'
    end
  end

  resources :activity_types

  resources :activities

  resources :users

  resources :way_places

  resources :trips do
    resources :routes
  end

  root :to => 'welcome#index'

end
