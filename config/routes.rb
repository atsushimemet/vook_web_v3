Rails.application.routes.draw do
  get 'line/:name', to: 'lines#show', as: :line, constraints: { name: /[^\/]+/ }
  get 'item/:name', to: 'items#show', as: :item, constraints: { name: /[^\/]+/ }
  get 'brand/:name', to: 'brands#show', as: :brand, constraints: { name: /[^\/]+/ }
  delete '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/about', to: 'home#about'
  resources :knowledges
  resources :magazines, path: '/magazine'
  resources :brands, only: [] do
    resources :lines, only: :index
  end
  root 'home#index'
  if Rails.env.production?
    match '*path', to: 'application#render_not_found', via: :all
  end
end
