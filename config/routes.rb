Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :categories, only: [:index, :show] do
        resources :products, only: [:create, :index, :show, :update] do
          collection do
            get 'download'
          end
        end  
      end  
      resources :auth, only: [] do
        collection do
          post 'login'
        end  
      end  
    end
  end    
end
