Rails.application.routes.draw do
  root 'planners#new'
  resources :planners, only: %i[new create show edit update destroy]
  resources :customers, only: %i[new create show edit update destroy]
end

