require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  post 'accounts/login', to: 'accounts#login'
  get 'accounts/me', to: 'accounts#me'
  get '/spotify_login', to: 'webhook#spotify_login'

  resources :ongoing_playlists, only: %i[update create destroy index]
  resources :spotify_playlists, only: %i[show index]
  resources :votations

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
