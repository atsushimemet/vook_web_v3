Rails.application.routes.draw do
  get 'item/:name', to: 'items#show'
  get 'brand/:name', to: 'brands#show'
  resources :knowledges
  resources :magazines, path: '/magazine'
  root 'home#index'
end
