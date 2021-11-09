Rails.application.routes.draw do
  resources :spotify_songs
  resources :spotify_playlists
  resources :accounts do
  end
  post 'accounts/login', to: 'accounts#login'
  resources :users

  get '/spotify_login', to: 'webhook#spotify_login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
