Rails.application.routes.draw do
  get '/login' => 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get  'static_pages/choose' => 'static_pages#choose'
  root 'static_pages#home'
  post    '/planners/:id', to: 'reservations#create'
  get     '/customers/search', to: 'customers#search'
  get     '/customers/schedule', to: 'customers#schedule'
  post    '/reservations/:id', to: 'reservations#update'
  get     '/planners/schedule', to: 'planners#schedule'
  resources :planners, only: %i[new create show edit update destroy]
  resources :customers, only: %i[new create show destroy]
  resources :reservations, only: %i[create update destroy]
end

