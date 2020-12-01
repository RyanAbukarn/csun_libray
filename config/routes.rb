Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "books#index"

  resource :session
  resources :users
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
