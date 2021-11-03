class PlaylistImportWorker
  def perform(user_id)
    user = SpotifyUser.find(user_id)

    user.playlists.fetch(:items).each do |api_playlist|
      SpotifyPlaylist.create!(
        spotify_user: user,
        external_id: api_playlist.fetch(:id),
        name: api_playlist.fetch(:name),
        description: api_playlist.fetch(:description),
      )
    end
  end
end
