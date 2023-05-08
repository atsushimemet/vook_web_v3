Rails.application.routes.draw do
  get 'line/:name', to: 'lines#show', as: :line, constraints: { name: /[^\/]+/ }
  get 'item/:name', to: 'items#show', as: :item, constraints: { name: /[^\/]+/ }
  get 'brand/:name', to: 'brands#show', as: :brand, constraints: { name: /[^\/]+/ }
  get '/auth/:provider/callback', to: 'sessions#create'
  resources :knowledges
  resources :magazines, path: '/magazine'
  root 'home#index'
end
