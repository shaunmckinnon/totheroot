Rails.application.routes.draw do

  # Authenticated routes
  devise_for :users

  resources :product_registrations
  get 'ProductRegistration', to: 'product_registrations#index'

  get '/products/:slug', to: 'products#shop_section'
  get '/products/:slug/:id', to: 'products#details'
  get '/products/:slug/:id/edit', to: 'products#edit'
  post '/product/:id', to: 'products#update'

  root 'home#index'

  match '*any' => 'application#options', :via => [:options]

  get 'sitemap.xml', :to => 'sitemap#index', :defaults => {:format => 'xml'}

  get 'contact-us', to: 'pages#contact'
  post 'contact-us', to: 'pages#contact_form_process'
  get 'about-us', to: 'pages#about'
  get 'faq', to: 'pages#faq'

  get 'news', to: 'news#list'

  resources :shop_sections
  resources :news_events
  get 'news/:id', to: 'news#event'

end
