Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'welcome#index', as: 'landing'

  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    resources :discover, only: [:index]
    resources :movies, only: [:index, :show] do
      resources :viewing_party, only: [:new, :create]
    end
  end

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/logout', to: 'users#logout'
end
