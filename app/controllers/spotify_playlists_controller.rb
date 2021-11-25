class SpotifyPlaylistsController < ApplicationController
  before_action :authenticate!, :set_playlists

  def index
    render_many @playlists, options: { except: %i[spotify_songs] }
  end

  def show
    render_one @playlists.find(params.require(:id)), options: { except: %i[sample_songs] }
  end

  private

  def set_playlists
    @playlists = @current_account.spotify_playlists
  end
end
