class OngoingPlaylistsController < ApplicationController
  before_action :authenticate!
  before_action :set_ongoing_playlist, only: %i[show update destroy create]

  def update
    nil
  end

  def create
    raise UnprocessableEntityError.new(message: 'An ongoing playlist already exists') if @ongoing_playlist

    ongoing_playlist = OngoingPlaylist.create!(creation_params)

    render_one ongoing_playlist
  end

  def show
    render_one @ongoing_playlist
  end

  def destroy
    @ongoing_playlist.destroy!
    render_one @ongoing_playlist
  end

  private

  def creation_params
    {
      account: @current_account,
      spotify_playlist: @current_account.spotify_playlists.find(params.require(:spotify_playlist_id))
    }
  end

  def set_ongoing_playlist
    @ongoing_playlist = @current_account.ongoing_playlist
  end
end
