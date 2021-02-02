Rails.application.routes.draw do
  root 'planners#new'
  resources :planners
end
