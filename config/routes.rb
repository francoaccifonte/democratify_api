# frozen_string_literal: true

require 'sidekiq/web'

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'

Rails.application.routes.draw do
  resources :account_settings, only: %i[index]
  resources :spotify_playlists, only: %i[show index]
  root 'welcome#index'
  mount Sidekiq::Web => '/sidekiq'

  get '/accounts/login', to: 'accounts#login'
  get '/accounts/signup', to: 'accounts#signup'
  post '/accounts/signup', to: 'api/accounts#signup'
  post '/accounts/login', to: 'accounts#login_form'
  get '/accounts/me', to: 'accounts#me'

  resources :accounts, only: [] do
    get '/votation', to: 'votations#show'
    put '/votation', to: 'votations#vote'
  end
  namespace :api do
    get '/spotify_login', to: 'webhook#spotify_login'
    resources :ongoing_playlists, only: %i[update create destroy index]
    resources :spotify_playlists, only: %i[show index update]
  end
end
