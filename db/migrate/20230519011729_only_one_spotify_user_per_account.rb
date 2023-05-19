class OnlyOneSpotifyUserPerAccount < ActiveRecord::Migration[7.0]
  def change
    remove_index :spotify_users, :account_id
    add_index :spotify_users, :account_id, unique: true

    drop_table :users do |t|
      t.string "hashed_password", null: false
      t.string "session_token", null: false
      t.string "email", null: false
      t.boolean "admin", default: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["email"], name: "index_users_on_email", unique: true
    end
  end
end
