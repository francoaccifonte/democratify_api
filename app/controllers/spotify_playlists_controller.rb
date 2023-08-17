class SpotifyPlaylistsController < ApplicationController
  before_action :set_spotify_playlist, only: %i[show]

  # GET /spotify_playlists
  def index
    redirect_to account_settings_url if @account.spotify_user.blank?
    @spotify_playlists = @account.spotify_playlists.all
  end

  # GET /spotify_playlists/1
  def show
    @spotify_playlist = @account.spotify_playlists.find(params.fetch(:id))
  end

  private

  def set_spotify_playlist
    @spotify_playlist = @account.spotify_playlists.find(params[:id])
  end

  def component_props
    @component_props =
      if action_name == 'index'
        {
          import_in_progress: PlaylistImportWorker.jobs_for_user?(@account.spotify_user&.id)
        }
      else
        {}
      end
  end
end
