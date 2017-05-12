Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #devise_for :users
  devise_for :users #, :controllers => { registrations: 'users/registrations' }
  devise_for :installs
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

  resources :categories do
    resources :subcategories
  end

  resources :listings do
    collection do
      get 'search'
      # get 'searchbyuser'       
    end    
    collection { post :import }
  end

  resources :repairshops do 
    collection do 
      get 'search'
    end
  end


  root 'categories#index'
  
  match '/help', to: 'pages#help', via: :get
  match '/scams', to: 'pages#scams', via: :get
  match '/safety', to: 'pages#safety', via: :get
  match '/terms', to: 'pages#terms', via: :get
  match '/policy', to: 'pages#policy', via: :get
  match '/about', to: 'pages#about', via: :get
  match '/contact', to: 'pages#contact', via: :get
  match '/mylistings', to: 'listings#mylistings', via: :get
  match '/subcategories/find_by_category', to: 'subcategories#find_by_category', via: :post

end

