Rails.application.routes.draw do
  
   namespace :api do
    namespace :v1 do
      post 'otp/verify', to: 'otp#verify'
    end
  end

  
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

    get 'posts/:id', to: 'posts#show' 
    root 'j_users#index'
end
