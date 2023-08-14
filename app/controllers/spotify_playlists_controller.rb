class SpotifyPlaylistsController < ApplicationController
  before_action :set_spotify_playlist, only: %i[show]
  before_action :redirect_if_no_auth

  # GET /spotify_playlists
  def index
    @spotify_playlists = @account.spotify_playlists.all
  end

  # GET /spotify_playlists/1
  def show
    @spotify_playlist = @account.spotify_playlists.find(params.fetch(:id))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_spotify_playlist
    @spotify_playlist = @account.spotify_playlists.find(params[:id])
  end

  def redirect_if_no_auth
    redirect_to account_settings_path if @account.spotify_user.blank?
  end
end
