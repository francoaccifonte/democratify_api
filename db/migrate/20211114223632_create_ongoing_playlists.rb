class CreateOngoingPlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :ongoing_playlists do |t|
      t.timestamps
    end

    add_reference :ongoing_playlists, :account, foreign_key: true, index: true, null: false
    add_reference :ongoing_playlists, :spotify_playlist, foreign_key: true, index: true, null: false
    add_reference :ongoing_playlists, :spotify_playlist_song, foreign_key: true, index: true, null: true
    add_index :ongoing_playlists, %i[account_id spotify_playlist_id], unique: true
  end
end
