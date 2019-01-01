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
    #routes for breakfast 
    get '/addmenuitem',    to: 'dashboard#add_new_menu_items'
    get '/updatemenuitem', to: 'dashboard#update_menu_items'
    get '/searchmenuitem', to: 'dashboard#search_menu_items'
    get '/deletemenuitem', to: 'dashboard#delete_menu_items'
    
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

  resources :breakfasts, except: [:index]
  get '/search_breakfast', to:  'breakfasts#search_form'
  get '/breakfast_profile', to: 'breakfasts#show'

  resources :lunches, except: [:index]
  get '/search_lunch', to: 'lunches#search_form'
  get '/lunch_profile', to: 'lunches#show'

  resources :happy_hours, except: [:index]
  get '/search_happyhour', to: 'happy_hours#search_form'
  get '/happyhour_profile', to: 'happy_hours#show'

  resources :dinners, except: [:index]
  get 'search_dinner', to: 'dinners#search_form'
  get 'dinner_profile', to: 'dinners#show'
  

end
