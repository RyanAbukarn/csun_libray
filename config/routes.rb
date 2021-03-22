Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "books#index"

  resource :session
  resources :users

  namespace :api do
    namespace :v1 do

      post 'authenticate', to: 'authentication#create'
      post 'authenticate/newAccount', to: 'authentication#create_new_account'

      get 'all_books' => "books#all_books"
      get 'my_account' => "users#my_account"
      get 'my_library' => "users#my_library"
      post 'edit_my_account' => "users#edit_my_account"
      post "update_registration" => "users#update_registration"
      delete 'delete_my_account'=>"users#delete_my_account"
      delete 'destroy_registration' => "users#destroy_registration"
      delete 'logout' =>'users#logout'
      post 'rent' => "users#rent"
      resources :books
    end
  end

  resources :books do
    resources :registrations
  end
  get 'dashborad'=> 'users#dashboard'
  get 'all_users'=> 'users#all_users'

  get 'cities/:state' => 'application#cities'
  
  get 'by_date' => 'books#by_date'
  post 'by_date' => 'books#by_date'

  get 'all_books' =>"books#all_books"
  get "signup" => "users#new"

end
