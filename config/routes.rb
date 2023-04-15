Rails.application.routes.draw do
  resources :magazines, path: '/magazine'
  root 'home#index'
end
