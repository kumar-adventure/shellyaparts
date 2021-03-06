require 'sidekiq/web'
Rails.application.routes.draw do

  namespace :admin do
    resources :plans
    resources :addons
    resources :configurations, only: :index
    namespace :configurations do
      resources :vehicle_makes
      resources :vehicle_models
      resources :category_types
      resources :categories
      resources :vehicle_options, except: [:show, :new]
    end
  end

  mount Sidekiq::Web, at: '/sidekiq'

  resources :subscriptions, only: [:index, :new, :create, :destroy]
  resources :plans, only: :index

  devise_for :users, controllers: { sessions: "users/sessions", passwords: "users/passwords", registrations: 'users/registrations' }
  devise_for :admins, :skip => :registrations, path: "admin", path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: { sessions: "admin/sessions", passwords: "admin/passwords" }

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  match "*path", :to => "application#routing_error", :via => :all
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
