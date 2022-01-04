class ChangeSpotifyPlaylistIndex < ActiveRecord::Migration[6.1]
  def change
    remove_index :spotify_playlist, name: :index_spotify_playlists_on_external_id
    add_index :spotify_playlists, :external_id, unique: false
  end
end
