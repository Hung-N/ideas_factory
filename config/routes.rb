Rails.application.routes.draw do


  get 'users/new'

  get 'users/create'

  resources :ideas

  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
