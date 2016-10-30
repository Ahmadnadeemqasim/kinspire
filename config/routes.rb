Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root  'static_pages#index'
  get   '/signup',            to: 'user_accounts#new'
  post  '/signup',            to: 'user_accounts#create'
  resources :user_accounts
end
