class ChangeOngoingPlaylistCurrentSong < ActiveRecord::Migration[6.1]
  def change
    remove_column :ongoing_playlists, :spotify_playlist_song_id
    add_reference :ongoing_playlists, :playing_song, foreign_key: { to_table: :spotify_playlist_songs }, index: true, null: false
  end
end
