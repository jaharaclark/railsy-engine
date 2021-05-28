Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :revenue do
        resources :merchants, only: [:index, :show]
        end
      namespace :revenue do
        resources :items, only: [:index, :show]
        get '/unshipped', to: "search#unshipped"
        end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
        collection do
          get '/find', to: "search#find"
        end
      end
      resources :items, only: [:index, :show, :create, :destroy, :update] do
        resources :merchant, only: [:index], controller: :item_merchants
      end
    end
  end

end
