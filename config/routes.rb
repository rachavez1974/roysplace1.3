Rails.application.routes.draw do
  #log in routes for customers and admins

  
  


  get    '/customer/login',  to: 'sessions_customer#new'
  post   '/customer/login',  to: 'sessions_customer#create'
  delete '/customer/logout', to:  'sessions_customer#destroy'

  get    '/admin/login',   to: 'sessions_admin#new'
  post   '/admin/login',   to: 'sessions_admin#create'
  delete '/admin/logout',  to: 'sessions_admin#destroy'



  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get  '/about', to: 'static_pages#about', as: 'about'
  get  '/contact', to: 'static_pages#contact'
  get  '/menus', to: 'static_pages#menus'
  get  '/offers', to: 'static_pages#offers'
  get  '/bagged', to: 'static_pages#bagged'

  resources :users
  get 'customer/signup', to: 'users#new'
  post 'customer/signup', to: 'users#create'

end
