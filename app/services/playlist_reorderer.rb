class PlaylistReorderer
  def initialize(new_order:, spotify_playlist:)
    @new_order = new_order
    @playlist = case spotify_playlist.class.name
                when 'Integer'
                  SpotifyPlaylist.find(spotify_playlist)
                when 'SpotifyPlaylist'
                  spotify_playlist
                end
  end

  def self.call(*args, **kwargs)
    new(*args, **kwargs).call
  end

  def call
    validate_params!

    SpotifyPlaylist.transaction do
      @playlist.spotify_playlist_songs.update_all(index: nil) # rubocop:disable Rails/SkipsModelValidations

      @new_order.each_with_index do |song_id, index|
        @playlist.spotify_playlist_songs.find(song_id).update!(index:)
      end
    end
  end

  def validate_params!
    valid = true
    valid = false if @new_order.count != @playlist.spotify_playlist_songs.pluck(:id).count
    valid = false if @new_order.to_set != @playlist.spotify_playlist_songs.pluck(:id).to_set

    raise UnprocessableEntityError.new(message: 'songs are missing, or there are extra ones') unless valid
  end
end
