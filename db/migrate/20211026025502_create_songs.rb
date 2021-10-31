class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.string :title, null: false
      t.string :artist, null: false
      t.string :album
      t.bigint :year
      t.string :genre
      t.jsonb :metadata, default: {}

      t.timestamps
    end

    add_index :songs, :title, unique: false
    add_index :songs, :artist, unique: false
    add_index :songs, :album, unique: false
    add_reference :songs, :spotify_playlist, foreign_key: true
  end
end
