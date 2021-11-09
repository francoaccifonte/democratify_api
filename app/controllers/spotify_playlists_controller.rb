class SpotifyPlaylistsController < ApplicationController
  before_action :authenticate!

  def index
    @playlists = SpotifyPlaylist.where(account_id: params.require(:account_id))
  end

  def show
    render_one(SpotifyPlaylist.includes(:songs).find(params.require(:id)))
  end
end
