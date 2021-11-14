class CreateSpotifyUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :spotify_users do |t|
      t.string :spotify_id, null: false
      t.string :access_token
      t.string :refresh_token
      t.datetime :access_token_expires_at
      t.datetime :refresh_token_expires_at
      t.string :scope, null: false
      t.string :name
      t.string :email
      t.string :uri
      t.string :href, null: false
      t.timestamps
    end

    add_reference :spotify_users, :account, foreign_key: true
  end
end
