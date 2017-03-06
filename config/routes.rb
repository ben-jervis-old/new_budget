Rails.application.routes.draw do

  get 'sessions/new'

  get 'users/new'

  get 'users/show'

  root  'static_pages#home'
  get   '/signup', to: 'users#new'
  post  '/signup', to: 'users#create'
  resources :users, except: [:index, :new, :create]
end
