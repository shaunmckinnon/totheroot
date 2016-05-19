Rails.application.routes.draw do
  get '/.well-known/acme-challenge/:id' => 'pages#letsencrypt'
  resources :posts
  resources :categories
  resources :product_registrations
  get 'ProductRegistration', to: 'product_registrations#index'

  devise_for :users
  
  root 'home#index'

  get '/autocomplete', to: 'product#autocomplete_search', format: :json

  resource :etsy_product

  match '*any' => 'application#options', :via => [:options]

end
