Rails.application.routes.draw do

  get '/.well-known/acme-challenge/:id' => 'pages#letsencrypt'

  resources :product_registrations
  get 'ProductRegistration', to: 'product_registrations#index'

  get '/products/:slug', to: 'products#shop_section'

  devise_for :users
  
  root 'home#index'

  resources :etsy_product

  match '*any' => 'application#options', :via => [:options]

  get 'sitemap.xml', :to => 'sitemap#index', :defaults => {:format => 'xml'}

end
