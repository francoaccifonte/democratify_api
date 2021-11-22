class CreateSpotifySongs < ActiveRecord::Migration[6.1]
  def change
    create_table :spotify_songs do |t|
      t.string :title, null: false
      t.string :artist, null: false
      t.string :album
      t.bigint :year
      t.string :genre
      t.string :external_id, null: false
      t.jsonb :metadata, default: {}
      t.float :duration
      t.jsonb :cover_art, default: {}

      t.timestamps
    end

    add_index :spotify_songs, :title, unique: false
    add_index :spotify_songs, :artist, unique: false
    add_index :spotify_songs, :album, unique: false
    add_index :spotify_songs, :external_id, unique: false
    add_reference :spotify_songs, :spotify_playlist, foreign_key: true
  end
end
