Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root    'static_pages#homepage'
  get     '/signup',            to: 'user_accounts#new'
  post    '/signup',            to: 'user_accounts#create'
  get     '/login',             to: 'sessions#new'
  post    '/login',             to: 'sessions#create'
  delete  '/logout',            to: 'sessions#destroy'
  resources :user_accounts
end
