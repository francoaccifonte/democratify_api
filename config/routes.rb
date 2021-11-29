# frozen_string_literal: true

require 'sidekiq/web'

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'


Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  post '/accounts/login', to: 'accounts#login'
  get '/accounts/me', to: 'accounts#me'
  get '/spotify_login', to: 'webhook#spotify_login'

  resources :accounts, only: [] do
    get '/votation', to: 'votations#show'
    put '/votation', to: 'votations#vote'
  end
  resources :ongoing_playlists, only: %i[update create destroy index]
  resources :spotify_playlists, only: %i[show index]
  # resources :votations, only: %i[show] do
  #   put 'vote', on: :member
  # end
end
