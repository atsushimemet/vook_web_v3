Rails.application.routes.draw do
  resources :magazines
  root 'home#index'
end
