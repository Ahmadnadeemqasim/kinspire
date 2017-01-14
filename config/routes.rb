Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root                                  'static_pages#homepage'
  get     '/login',                 to: 'sessions#new'
  post    '/login',                 to: 'sessions#create'
  delete  '/logout',                to: 'sessions#destroy'
  get     '/kinployee-signup',      to: 'kinployees#new'
  post    '/kinployee-signup',      to: 'kinployees#create'
  get     '/kinployer-signup',      to: 'kinployers#new'
  post    '/kinployer-signup',      to: 'kinployers#create'
  resources :kinployees,            only: [ :show ]
  resources :kinployers,            only: [ :show ]
  get     '/new-job-1',             to: 'kinployments#new_step_1'
  post    '/new-job-2',             to: 'kinployments#new_step_2'
  resources :kinployments,          only: [ :new, :create, :show ] do
    get   'nominations',            to: 'nominations#index'
    member do
      patch 'disengage',            to: 'kinployments#disengage', as: 'disengage'
      patch 'engage/:kinployee_id', to: 'kinployments#engage',    as: 'engage'
    end
  end
  resources :users,                 only: [ :show ]
end