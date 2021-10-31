class CreateSpotifyPlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :spotify_playlists do |t|
      t.string :name
      t.string :description
      t.string :external_id
      t.string :external_url

      t.timestamps
    end

    add_reference :spotify_playlists, :account, foreign_key: true
    add_reference :spotify_playlists, :spotify_user, foreign_key: true
  end
end
