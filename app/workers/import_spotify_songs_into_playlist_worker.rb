class ImportSpotifySongsIntoPlaylistWorker
  # include Sidekiq::Worker
  # sidekiq_options queue: :spotify_import

  def perform(playlist_id)
    playlist = SpotifyPlaylist.find(playlist_id)

    client = Spotify::Client.new(access_token: playlist.spotify_user.access_token)
    songs = client.playlist_tracks(playlist.external_id).fetch(:items)

    songs.each do |song|
      song = song.fetch(:track)
      new_song = SpotifySong.find_or_initialize_by(
        spotify_playlist: playlist,
        external_id: song.fetch(:id)
      )
      new_song.assign_attributes(
        title: song.fetch(:name),
        artist: song.fetch(:artists).pluck(:name).join(' - '),
        album: song.fetch(:album).fetch(:name),
        cover_art: song.fetch(:album).fetch(:images),
        duration: song.fetch(:duration_ms)
      )
      new_song.save!
    end
  end
end
