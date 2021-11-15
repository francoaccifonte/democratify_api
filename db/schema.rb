# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_14_223632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["name"], name: "index_accounts_on_name", unique: true
  end

  create_table "ongoing_playlists", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id", null: false
    t.bigint "spotify_playlist_id", null: false
    t.index ["account_id", "spotify_playlist_id"], name: "index_ongoing_playlists_on_account_id_and_spotify_playlist_id", unique: true
    t.index ["account_id"], name: "index_ongoing_playlists_on_account_id"
    t.index ["spotify_playlist_id"], name: "index_ongoing_playlists_on_spotify_playlist_id"
  end

  create_table "spotify_playlists", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "external_id"
    t.string "external_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id"
    t.bigint "spotify_user_id", null: false
    t.index ["account_id"], name: "index_spotify_playlists_on_account_id"
    t.index ["spotify_user_id"], name: "index_spotify_playlists_on_spotify_user_id"
  end

  create_table "spotify_songs", force: :cascade do |t|
    t.string "title", null: false
    t.string "artist", null: false
    t.string "album"
    t.bigint "year"
    t.string "genre"
    t.string "external_id", null: false
    t.jsonb "metadata", default: {}
    t.float "duration"
    t.jsonb "cover_art", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "spotify_playlist_id"
    t.index ["album"], name: "index_spotify_songs_on_album"
    t.index ["artist"], name: "index_spotify_songs_on_artist"
    t.index ["spotify_playlist_id"], name: "index_spotify_songs_on_spotify_playlist_id"
    t.index ["title"], name: "index_spotify_songs_on_title"
  end

  create_table "spotify_users", force: :cascade do |t|
    t.string "spotify_id", null: false
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "access_token_expires_at"
    t.datetime "refresh_token_expires_at"
    t.string "scope", null: false
    t.string "name"
    t.string "email"
    t.string "uri"
    t.string "href", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id"
    t.index ["account_id"], name: "index_spotify_users_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "hashed_password", null: false
    t.string "session_token", null: false
    t.string "email", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "ongoing_playlists", "accounts"
  add_foreign_key "ongoing_playlists", "spotify_playlists"
  add_foreign_key "spotify_playlists", "accounts"
  add_foreign_key "spotify_playlists", "spotify_users"
  add_foreign_key "spotify_songs", "spotify_playlists"
  add_foreign_key "spotify_users", "accounts"
end