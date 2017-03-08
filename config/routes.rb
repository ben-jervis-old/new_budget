Rails.application.routes.draw do
  get     'users/show'
  get     '/expenses', to: 'expenses#index'
  post    '/expenses', to: 'expenses#create'
  put    '/users/:id/update_pay_period', to: 'users#update_pay_period', as: :update_pay_period
  root    'static_pages#home'
  get     '/signup', to: 'users#new'
  post    '/signup', to: 'users#create'
  get     '/login',  to: 'sessions#new'
  post    '/login',  to: 'sessions#create'
  delete  '/logout', to: 'sessions#destroy'
  resources :users, except: [:index, :new, :create]
end
