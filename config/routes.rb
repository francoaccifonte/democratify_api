Rails.application.routes.draw do
  resources :songs
  resources :playlists
  resources :accounts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
