Rails.application.routes.draw do
  root 'planners#new'
  resource :planners, only: %i[new create show edit update destroy]
end
