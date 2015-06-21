def multi(action)
  post :collection_action, constraints: ->(req) { req.params[:collection_action] == action.to_s }, action: "#{action}_multiple".to_sym
end

Rails.application.routes.draw do
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

  namespace :cmn do
    resources :lexicons, except: [:index, :create, :new] do
      #resource :settings

      resources :sentences, only: :index do
        get :search, on: :collection
        get :add, on: :collection
      end
      resources :lexical_entries, only: [:index, :create] do
        collection do
          get :quick_create
          multi :destroy
          multi :edit
        end
      end
    end
  end

end
