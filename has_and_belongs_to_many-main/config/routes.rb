Rails.application.routes.draw do
  resources :products do
    member do
      post 'add_to_store/:store_id', to: 'products#add_to_store'
      delete 'remove_from_store/:store_id', to: 'products#remove_from_store'
      get 'stores'
    end
  end
  
  resources :stores do
    member do
      post 'add_product/:product_id', to: 'stores#add_product'
      delete 'remove_product/:product_id', to: 'stores#remove_product'
      get 'products'
    end
  end
end