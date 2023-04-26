module Api
  class SpotifyPlaylistsController < Api::ApiController
    before_action :authenticate!, :set_playlists
    before_action :set_playlist, only: %i[update show]

    def index
      render_many @playlists, options: { except: %i[spotify_songs sample_songs] }
    end

    def show
      render_one @playlist, options: { except: %i[sample_songs] }
    end

    def update
      @playlist.update!(update_params)

      render_one @playlist, options: { except: %i[sample_songs] }
    end

    private

    def set_playlists
      @playlists = @current_account.spotify_playlists
    end

    def set_playlist
      @playlist = @playlists.find(params.require(:id))
    end

    def update_params
      {
        # add more params here
      }.merge!(spotify_playlist_songs_attributes)
    end

    def spotify_playlist_songs_attributes
      {
        spotify_playlist_songs_attributes: params.permit(spotify_playlist_songs: %i[id index]).to_h[:spotify_playlist_songs]
      }
    end
  end
end
