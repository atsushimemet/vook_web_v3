Rails.application.routes.draw do
  get 'line/:name', to: 'lines#show', as: :line
  get 'item/:name', to: 'items#show', as: :item
  get 'brand/:name', to: 'brands#show', as: :brand
  resources :knowledges
  resources :magazines, path: '/magazine'
  root 'home#index'
end
