class CreateOngoingPlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :ongoing_playlists do |t|

      t.timestamps
    end

    add_reference :ongoing_playlists, :account, foreign_key: true, index: true, null: false
    add_reference :ongoing_playlists, :spotify_playlists, foreign_key: true, index: true, null: false
  end
end
