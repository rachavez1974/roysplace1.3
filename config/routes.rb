Rails.application.routes.draw do

  get    '/customer/login',  to: 'sessions#new_user_session'
  post   '/customer/login',  to: 'sessions#create_user_session'
  delete '/customer/logout',  to: 'sessions#destroy'

  

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
