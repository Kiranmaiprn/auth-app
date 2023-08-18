Rails.application.routes.draw do
 


 devise_scope :user   do
   get "/pop", to: "users/registrations#pop", as: "users_pop"
   
 end



  devise_for :users,controllers:{sessions: 'users/sessions',registrations: 'users/registrations'} 

  get 'member_details' ,to: "members#index"


  namespace :api do
    namespace :v1 do
      resources :companies
    end
  end
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
