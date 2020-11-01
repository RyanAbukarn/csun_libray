Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :session

  get "signup" => "users#new"
  resources :users
  root "books#index"
  resources :books do
    resources :registrations
  end
end
