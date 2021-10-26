class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.where(account_id: params.require(:account_id))
  end

  def show
    @playlist = Playlist.find(params.require(:id))
  end

  def create
    new_playlist = Playlist.create!(playlist_params)
    render json: new_playlist, status: :created
  end
end
