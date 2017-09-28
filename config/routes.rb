Rails.application.routes.draw do

  root 'lp#index'
  get 'lp', to: 'lp#index'

  resources :experiments, only: [ :new, :create, :show ]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
