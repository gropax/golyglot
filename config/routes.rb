Rails.application.routes.draw do
  resources :lexicons
  resources :lexical_resources
  root :to => "home#index"

  get "home" => "home#index", as: "home"

  resources :sessions
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"

  get "sign_up" => "users#new", :as => "sign_up"
  resources :users, only: [:new, :create] do
    resource :settings, only: [:show, :update]
    resources :lexical_resources, only: [:index, :create, :new]
  end

  resources :lexical_resources, except: [:index, :create, :new] do
    resource :settings, only: [:show, :update]
    resources :lexicons, only: [:index, :create, :new]
    resources :sense_axis, only: [:index, :create, :new]
    resources :sentence_axis, only: [:index, :create, :new]
  end

  resources :lexicons, except: [:index, :create, :new] do
    resource :settings

    resources :sentences, only: :index do
      get :search, on: :collection
      get :add, on: :collection
    end
    resources :lexical_entries, only: :index
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
