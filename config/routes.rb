Rails.application.routes.draw do

  get 'static_pages/about'

  get 'static_pages/contact'

  get 'static_pages/menus'

  get 'static_pages/offers'

  get 'static_pages/bagged'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
