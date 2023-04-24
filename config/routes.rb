Rails.application.routes.draw do
  resources :knowledges
  resources :magazines, path: '/magazine'
  root 'home#index'
end
