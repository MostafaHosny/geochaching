Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :locations, only: [:create] do
        collection do 
          get 'nearby'
          get 'closest'
        end
      end
   end
  end
end
