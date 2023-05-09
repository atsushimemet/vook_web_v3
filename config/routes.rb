Rails.application.routes.draw do
  get 'line/:name', to: 'lines#show', as: :line, constraints: { name: /[^\/]+/ }
  get 'item/:name', to: 'items#show', as: :item, constraints: { name: /[^\/]+/ }
  get 'brand/:name', to: 'brands#show', as: :brand, constraints: { name: /[^\/]+/ }
  delete '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  resources :knowledges
  resources :magazines, path: '/magazine'
  root 'home#index'
end
