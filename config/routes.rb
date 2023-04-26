Rails.application.routes.draw do
  get 'brand/:name', to: 'brands#show'
  resources :knowledges
  resources :magazines, path: '/magazine'
  root 'home#index'
end
