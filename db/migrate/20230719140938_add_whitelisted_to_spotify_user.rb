class AddWhitelistedToSpotifyUser < ActiveRecord::Migration[7.0]
  def change
    change_column_null :spotify_users, :href, true
    change_column_null :spotify_users, :scope, true
    change_column_null :spotify_users, :spotify_id, true

    add_column :spotify_users, :user_provided_email, :string, null: false
    add_column :spotify_users, :whitelisted, :boolean, default: false
  end
end
