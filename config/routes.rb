Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root                              'static_pages#homepage'
  get     '/login',             to: 'sessions#new'
  post    '/login',             to: 'sessions#create'
  delete  '/logout',            to: 'sessions#destroy'
  get     '/kinployee-signup',  to: 'kinployees#new'
  post    '/kinployee-signup',  to: 'kinployees#create'
  get     '/kinployer-signup',  to: 'kinployers#new'
  post    '/kinployer-signup',  to: 'kinployers#create'
  resources :kinployees,  only: [ :show ]
  resources :kinployers,  only: [ :show ]
  resources :users,       only: [ :show ]
end
