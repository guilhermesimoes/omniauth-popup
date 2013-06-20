OmniauthPopup::Application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get '/sign_out' => 'sessions#destroy', :as => :sign_out

  resources :users, only: [:show, :index, :destroy]

  root to: 'pages#home'
end
