Rails.application.routes.draw do
  

  

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
    get '/addcustomer', to: 'users#new'
    post '/addcustomer', to: 'users#create'
    get '/customer/:id/edit', to: 'users#edit'
    patch '/customer/:id/edit', to: 'users#update'
    get '/showcustomer', to: 'users#show'

    get '/search_customer', to: 'users#search_form'
    
    get '/additem', to: 'dashboard#add_new_breakfast_items'
    get '/updateitem', to: 'dashboard#update_breakfast_items'
    get '/searchitem', to: 'dashboard#search_breakfast_items'
    get '/deleteitem', to: 'dashboard#delete_breakfast_items'

    
    resources :users, except: [:new, :create, :index, :edit, :update]
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

  resources :breakfasts
  get '/search_breakfast', to: 'breakfasts#search_form'
  get '/breakfast_profile', to: 'breakfasts#show'

  

end
