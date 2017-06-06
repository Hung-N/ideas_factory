Rails.application.routes.draw do



  resources :users, only: [:new, :create]

  resources :ideas do
    resources :reviews
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  get 'welcome/index', as: :home

  get 'review/hide/:id', to: 'reviews#flag', as: 'review_flag'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
