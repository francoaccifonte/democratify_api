class CreatePlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    add_reference :playlists, :account, foreign_key: true
  end
end
