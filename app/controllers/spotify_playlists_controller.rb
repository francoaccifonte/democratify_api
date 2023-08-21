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

  def index_props
    {
      # import_in_progress: PlaylistImportWorker.jobs_for_user?(@account.spotify_user&.id),
      account: serialized_account(@account),
      playlists: serialize_many(@spotify_playlists, options: { except: %i[spotify_songs sample_songs] })
    }
  end

  def show_props
    {
      account: serialized_account(@account),
      playlist: serialize_one(@spotify_playlist)
    }
  end
end
