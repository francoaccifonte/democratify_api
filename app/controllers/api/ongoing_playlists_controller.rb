# frozen_string_literal: true

module Api
  class OngoingPlaylistsController < Api::ApiController
    before_action :authenticate!
    before_action :set_ongoing_playlist, only: %i[index update destroy create]
    rescue_from Spotify::Errors::DeviceNotFoundError, with: :handle_device_error

    def index
      render_one @ongoing_playlist
    end

    def create
      @ongoing_playlist = ShowStarter.call(account: @current_account, spotify_playlist:)

      render_one @ongoing_playlist
    end

    def update
      ActiveRecord::Base.transaction do
        @ongoing_playlist.update!(update_params)
        PlaylistReorderer.call(new_order: song_order, spotify_playlist: @ongoing_playlist.spotify_playlist) if song_order
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
      # looks like { spotify_playlist_songs: [3131, 1412, 5154, 343] } all ids from songs already in the palylist
      @song_order ||= params.permit(spotify_playlist_songs: [])['spotify_playlist_songs']&.map(&:to_i)
    end

    def handle_device_error
      render json: { error: 'there is no active spotify device' }, status: :bad_request
    end
  end
end
