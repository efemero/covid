Rails.application.routes.draw do
  resources :tests
  get 'map/index'
  root 'tests#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
