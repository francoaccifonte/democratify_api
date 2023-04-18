# frozen_string_literal: true

class OngoingPlaylistsController < ApiController
  before_action :authenticate!
  before_action :set_ongoing_playlist, only: %i[index update destroy create]

  def index
    render_one @ongoing_playlist
  end

  def create
    @ongoing_playlist&.destroy!
    ongoing_playlist = OngoingPlaylist.create!(creation_params)

    render_one ongoing_playlist
  end

  def update
    ActiveRecord::Base.transaction do
      @ongoing_playlist.update!(update_params)
      @ongoing_playlist.reorder_songs(song_order) if song_order
    end
  end

  def destroy
    @ongoing_playlist.destroy!
    render_one @ongoing_playlist
  end

  private

  def creation_params
    {
      account: @current_account,
      spotify_playlist:,
      playing_song_id: playing_song&.id
    }
  end

  def set_ongoing_playlist
    @ongoing_playlist = @current_account.ongoing_playlist
  end

  def spotify_playlist
    @spotify_playlist ||= @current_account.spotify_playlists.find(params.require(:spotify_playlist_id))
  end

  def playing_song
    @playing_song ||= (spotify_playlist.spotify_playlist_songs.find(params.require(:playing_song_id)) if params.permit(:playing_song_id).present?)
  end

  def update_params
    params.permit(:pool_size).to_h
  end

  def song_order
    @song_order ||= params.permit(spotify_playlist_songs: %i[id index]).to_h[:spotify_playlist_songs]
  end
end
