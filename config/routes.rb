Rails.application.routes.draw do
  get '/login' => 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get  'static_pages/choose' => 'static_pages#choose'
  root 'static_pages#home'
  post    '/planners/:id', to: 'reservations#create'
  post    '/planners/:id/edit', to: 'planners#update'
  resources :planners, only: %i[new create show edit update destroy]
  resources :customers, only: %i[new create show edit update destroy]
end

