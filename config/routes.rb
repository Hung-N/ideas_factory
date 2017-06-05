Rails.application.routes.draw do


  get 'reviews/new'

  get 'reviews/create'

  get 'reviews/destroy'

  resources :users, only: [:new, :create]

  resources :ideas

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  get 'welcome/index', as: :home

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
