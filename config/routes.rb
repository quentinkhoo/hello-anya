Rails.application.routes.draw do
  root 'pages#index'
  get 'pages/anya'
  resources :user_sessions, only: [:new, :create]
  resources :users, only: [:index, :new, :create]
  match '*path', to: 'application#not_found_method', via: :all
end
