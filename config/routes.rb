Rails.application.routes.draw do
  devise_for :users
  
  root 'home#index'

  get '/', to: 'home#index', format: :json

  resource :etsy_product

end
