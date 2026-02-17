Rails.application.routes.draw do

  resources :j_users do
    resources :profiles do
      resources :posts do 
        collection do
          get :feed
     end 
  end  
  resources :conferences
end   
end 

    post 'login', to: 'sessions#create',
    delete 'logout', to: 'sessions#destroy', 

    get 'posts/:id', to: 'posts#show' 
    root 'j_users#index'
end
