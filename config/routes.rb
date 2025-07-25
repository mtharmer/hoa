Rails.application.routes.draw do
  resources :documents, only: [:index, :create, :destroy]
  get 'documents/download/:id', to: 'documents#download', as: 'download_document'
  resources :comments, only: [:create, :destroy]
  resources :posts, except: [:show, :edit, :update]
  resources :addresses
  resources :users, except: [:create, :new]
  devise_for :users, path: 'auth', controllers: {
    registrations: 'registrations',
    sessions: 'sessions'
  }
  devise_scope :user do
    get 'auth/profile', to: 'registrations#profile', as: :edit_profile
    put 'auth/update_profile', to: 'registrations#update_profile', as: :profile
  end
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
