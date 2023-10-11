Rails.application.routes.draw do
  
 devise_scope :users   do
   get "/pop", to: "users/registrations#pop", as: "users_pop"
   get 'users/index', to: 'users/registrations#index'
 end

 devise_for :users, controllers: {
  sessions: "users/sessions",
  registrations: "users/registrations"}

  resources :users do 
    scope 'api/v1' do
      resources :companies
    end
  end

  # resources :users do
  #   namespace :api do
  #      resources :companies 
  #   end
  # end

  # resources :companies do
  #   resources :comments
  # end
  
  # 

  get 'member_details' ,to: "members#index"

  

  #
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
