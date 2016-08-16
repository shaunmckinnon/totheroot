Rails.application.routes.draw do

  get '/.well-known/acme-challenge/:id' => 'pages#letsencrypt'

  resources :posts
  resources :categories
  
  resources :product_registrations
  get 'ProductRegistration', to: 'product_registrations#index'

  get '/products/:shop_section_id', to: 'products#shop_section'

  devise_for :users
  
  root 'home#index'

  get '/autocomplete', to: 'product#autocomplete_search', format: :json

  resource :etsy_product

  match '*any' => 'application#options', :via => [:options]

  get 'sitemap.xml', :to => 'sitemap#index', :defaults => {:format => 'xml'}

end
