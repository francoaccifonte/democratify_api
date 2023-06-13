class IndexSpotifyPlaylistSongsIndex < ActiveRecord::Migration[7.0]
  def change
    remove_index :spotify_playlist_songs, %i[spotify_playlist_id index]
    add_index :spotify_playlist_songs, %i[spotify_playlist_id index], unique: true
  end
end
