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
      get 'map_distance'
    end
  end

  resources :activity_types

  resources :activities

  resources :users

  resources :way_places

  resources :trips do
    resources :routes do
      collection do
        get 'cleanup'
      end
    end
  end

  root :to => 'welcome#index'

end
