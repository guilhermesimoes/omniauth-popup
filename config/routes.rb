OmniauthPopup::Application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'

  scope ':locale', locale: /#{I18n.available_locales.join('|')}/ do
    get '/sign_out' => 'sessions#destroy', :as => :sign_out

    resources :users, only: [:show, :index, :destroy]

    root to: 'pages#home'
  end

  get '*path' => redirect("/#{I18n.default_locale}/%{path}")
  get '' => redirect("/#{I18n.default_locale}")
end
