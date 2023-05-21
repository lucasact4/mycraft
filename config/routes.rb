Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'
  
  resources :posts do
    resources :comments, only: [:create]
  end

  get '/signup', to: 'players#new'
  resources :players, except: [:new]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :items

end
