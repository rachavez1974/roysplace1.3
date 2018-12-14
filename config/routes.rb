Rails.application.routes.draw do
  

  namespace :admin do
    get 'dashboard/home'
  end

  namespace :customer do
    get '/login',  to: 'sessions#new'
    post '/login',  to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'


    get '/signup', to: 'users#new'
    post '/signup', to: 'users#create'
    resources :users, except: [:new, :create]
    resources :account_activations, only: [:edit]
    resources :password_resets,     only: [:new, :create, :edit, :update]

  end
  
  namespace :admin do
    get '/login', to: 'sessions#new'
    post '/login',  to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    root to: 'dashboard#home'
    get '/signup', to: 'users#new'
    post '/signup', to: 'users#create'
    get '/search_customer', to: 'users#search_form'
    get '/profile', to: 'users#show'
    resources :users, except: [:new, :create]
    resources :account_activations, only: [:edit]
    resources :password_resets,     only: [:new, :create, :edit, :update]

  end

  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get  '/about', to: 'static_pages#about', as: 'about'
  get  '/contact', to: 'static_pages#contact'
  get  '/menus', to: 'static_pages#menus'
  get  '/offers', to: 'static_pages#offers'
  get  '/bagged', to: 'static_pages#bagged'

  # resources :account_activations, only: [:edit]
  # resources :password_resets,     only: [:new, :create, :edit, :update]

end
