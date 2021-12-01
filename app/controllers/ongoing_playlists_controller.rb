# frozen_string_literal: true

class OngoingPlaylistsController < ApplicationController
  before_action :authenticate!
  before_action :set_ongoing_playlist, only: %i[index update destroy create]

  def update
    @ongoing_playlist.update!(update_params)
  end

  def create
    @ongoing_playlist&.destroy!
    ongoing_playlist = OngoingPlaylist.create!(creation_params)

    render_one ongoing_playlist
  end

  def index
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
      spotify_playlist: spotify_playlist,
      playing_song: playing_song
    }
  end

  def set_ongoing_playlist
    @ongoing_playlist = @current_account.ongoing_playlist
  end

  def spotify_playlist
    @spotify_playlist ||= @current_account.spotify_playlists.find(params.require(:spotify_playlist_id))
  end

  def playing_song
    @playing_song ||= if params.permit(:playing_song_id).present?
                        spotify_playlist.spotify_playlist_songs.find(params.require(:playing_song_id))
                      else
                        spotify_playlist.spotify_playlist_songs.first
                      end
  end

  def update_params
    params.permit(:pool_size).to_h
          .merge!(spotify_playlist_songs_attributes)
  end

  def spotify_playlist_songs_attributes
    {
      spotify_playlist_songs_attributes: params.permit(spotify_playlist_songs: %i[id index]).to_h[:spotify_playlist_songs]
    }
  end
end
