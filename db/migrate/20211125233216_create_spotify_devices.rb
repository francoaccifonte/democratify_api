class CreateSpotifyDevices < ActiveRecord::Migration[6.1]
  def change
    create_table :spotify_devices do |t|
      t.string :external_id, null: false
      t.string :name, null: false
      t.string :device_type, null: false
      t.boolean :is_active, default: false, null: false
      t.boolean :is_private_session, default: false
      t.boolean :is_restricted, default: false
      t.boolean :is_selected, default: false
      t.timestamps
    end

    add_reference :spotify_devices, :spotify_user, foreign_key: true, null: false, index: true
  end
end
