Rails.application.routes.draw do

  get 'users/new'

  get 'users/show'

  root  'static_pages#home'
  get   '/signup', to: 'users#new'
  resources :users, except: :index
end
