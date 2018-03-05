Rails.application.routes.draw do
    
 
  
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #devise_for :users

  
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  
  devise_for :installs

  resources :users do      
    resources :reviews, only: [ :new, :edit, :create, :update, :destroy] do 
      member do
        get :raise_appeal
      end 
    end

    resources :timetables, only: [:new, :edit, :create, :update, :destroy]
  end



  resources :categories

  resources :listings do
    collection do
      get 'search'
      get 'dealer_search'
      get 'bodysearch'      
    end    
    collection { post :import }
  end

  resources :repairshops do 
    resources :brands_we_services, only: [ :new, :edit, :create, :update, :destroy]
    resources :coupons, only: [ :new, :edit, :create, :update, :destroy]
    resources :specializations, only: [ :new, :edit, :create, :update, :destroy]
    collection do 
      get 'search'
    end
  end

  resources :inquiries, only: [:new, :create, :edit, :update] do     
    member {  get :send_to_all }
    resources :notes, only: [:new, :create, :edit, :update]
  end

  resources :new_dealer_contacts, only: [:new, :create] 


  root 'categories#index'
  # mount Sidekiq::Web, at: '/sidekiq'

  match '/userpage/:id', to: 'listings#userpage', via: :get, as: "userpage"
  
  match '/help', to: 'pages#help', via: :get
  match '/scams', to: 'pages#scams', via: :get
  match '/safety', to: 'pages#safety', via: :get
  match '/terms', to: 'pages#terms', via: :get
  match '/policy', to: 'pages#policy', via: :get
  match '/about', to: 'pages#about', via: :get
  match '/contact', to: 'pages#contact', via: :get
  match '/mylistings', to: 'listings#mylistings', via: :get
  
  match '/myrepairshops', to: 'repairshops#myrepairshops', via: :get

  match '/usedcars', to: 'listings#usedcars', via: :get
  match '/newcars', to: 'listings#newcars', via: :get  
  match '/signup_thankyou', to: 'pages#signup_thankyou', via: :get 
  match '/dealercorner', to: 'pages#dealercorner', via: :get 
  match '/pricing', to: 'pages#pricing', via: :get 
  match '/subcategories/find_by_category', to: 'subcategories#find_by_category', via: :post

  match '/allcoupons', to: 'coupons#index', via: :get  



end


