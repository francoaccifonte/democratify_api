class CreateSpotifyPlaylistSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :spotify_playlist_songs do |t|
      t.datetime :enqueued_at
      t.integer :index

      t.timestamps
    end

    add_reference :spotify_playlist_songs, :spotify_playlist, foreign_key: true, null: false, index: true
    add_reference :spotify_playlist_songs, :spotify_song, foreign_key: true, null: false, index: true
    add_index :spotify_playlist_songs, %i[spotify_playlist_id index]
  end
end
