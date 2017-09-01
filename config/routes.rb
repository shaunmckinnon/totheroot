Rails.application.routes.draw do

  # Authenticated routes
  devise_for :users

  resources :product_registrations
  get 'ProductRegistration', to: 'product_registrations#index'

  get '/products/:slug', to: 'products#shop_section'

  root 'home#index'

  resources :etsy_product

  match '*any' => 'application#options', :via => [:options]

  get 'sitemap.xml', :to => 'sitemap#index', :defaults => {:format => 'xml'}

  get 'contact-us', to: 'pages#contact'
  post 'contact-us', to: 'pages#contact_form_process'
  get 'about-us', to: 'pages#about'

  resources :shop_sections

end
