class SpotifyPlaylistsController < ApplicationController
  before_action :authenticate!

  def index
    @playlists = SpotifyPlaylist.where(account_id: @current_account.id)

    render_many @playlists
  end

  def show
    render_one(SpotifyPlaylist.includes(:songs).find(params.require(:id)))
  end
end
