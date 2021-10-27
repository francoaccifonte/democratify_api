Rails.application.routes.draw do
  resources :integrations
  resources :songs
  resources :playlists
  resources :accounts
  resources :users

  get '/spotify_login', to: 'webhook#spotify_login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
