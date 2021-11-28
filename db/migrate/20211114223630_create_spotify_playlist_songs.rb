class CreateSpotifyPlaylistSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :spotify_playlist_songs do |t|
      t.datetime :enqueued_at

      t.timestamps
    end

    add_reference :spotify_playlist_songs, :spotify_playlist, foreign_key: true, null: false, index: true
    add_reference :spotify_playlist_songs, :spotify_song, foreign_key: true, null: false, index: true
  end
end
