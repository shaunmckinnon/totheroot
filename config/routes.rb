Rails.application.routes.draw do
  devise_for :users
  
  root 'home#index'

  resource :etsy_product

  match '*any' => 'application#options', :via => [:options]

end
