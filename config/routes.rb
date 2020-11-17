Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :session
  get 'cities/:state' => 'application#cities'
  get 'all_books' =>"books#all_books"
  get "signup" => "users#new"
  resources :users
  root "books#index"
  get "by_date"=>"books#by_date_new"
  post "by_date"=>"books#by_date"
  resources :books do
    resources :registrations
  end

end
