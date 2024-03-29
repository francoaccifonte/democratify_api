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

ActiveRecord::Schema[7.0].define(version: 2023_07_19_140938) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "token", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "password_digest"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["name"], name: "index_accounts_on_name", unique: true
  end

  create_table "ongoing_playlists", force: :cascade do |t|
    t.integer "pool_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id", null: false
    t.bigint "spotify_playlist_id", null: false
    t.bigint "playing_song_id", null: false
    t.index ["account_id", "spotify_playlist_id"], name: "index_ongoing_playlists_on_account_id_and_spotify_playlist_id", unique: true
    t.index ["account_id"], name: "index_ongoing_playlists_on_account_id"
    t.index ["playing_song_id"], name: "index_ongoing_playlists_on_playing_song_id"
    t.index ["spotify_playlist_id"], name: "index_ongoing_playlists_on_spotify_playlist_id"
  end

  create_table "spotify_playlist_songs", force: :cascade do |t|
    t.datetime "enqueued_at", precision: nil
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "spotify_playlist_id", null: false
    t.bigint "spotify_song_id", null: false
    t.index ["spotify_playlist_id", "index"], name: "index_spotify_playlist_songs_on_spotify_playlist_id_and_index", unique: true
    t.index ["spotify_playlist_id"], name: "index_spotify_playlist_songs_on_spotify_playlist_id"
    t.index ["spotify_song_id"], name: "index_spotify_playlist_songs_on_spotify_song_id"
  end

  create_table "spotify_playlists", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "external_id"
    t.string "external_url"
    t.string "cover_art_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.bigint "spotify_user_id", null: false
    t.index ["account_id"], name: "index_spotify_playlists_on_account_id"
    t.index ["external_id"], name: "index_spotify_playlists_on_external_id"
    t.index ["spotify_user_id"], name: "index_spotify_playlists_on_spotify_user_id"
  end

  create_table "spotify_songs", force: :cascade do |t|
    t.string "title", null: false
    t.string "artist", null: false
    t.string "album"
    t.bigint "year"
    t.string "genre"
    t.string "external_id", null: false
    t.string "uri", null: false
    t.jsonb "metadata", default: {}
    t.float "duration"
    t.jsonb "cover_art", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album"], name: "index_spotify_songs_on_album"
    t.index ["artist"], name: "index_spotify_songs_on_artist"
    t.index ["external_id"], name: "index_spotify_songs_on_external_id"
    t.index ["title"], name: "index_spotify_songs_on_title"
  end

  create_table "spotify_users", force: :cascade do |t|
    t.string "spotify_id"
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "access_token_expires_at", precision: nil
    t.datetime "refresh_token_expires_at", precision: nil
    t.string "scope"
    t.string "name"
    t.string "email"
    t.string "uri"
    t.string "href"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.string "user_provided_email", null: false
    t.boolean "whitelisted", default: false
    t.index ["account_id"], name: "index_spotify_users_on_account_id", unique: true
  end

  create_table "votation_candidates", force: :cascade do |t|
    t.bigint "votes", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.bigint "votation_id"
    t.bigint "spotify_playlist_song_id"
    t.bigint "ongoing_playlist_id"
    t.index ["account_id"], name: "index_votation_candidates_on_account_id"
    t.index ["ongoing_playlist_id"], name: "index_votation_candidates_on_ongoing_playlist_id"
    t.index ["spotify_playlist_song_id"], name: "index_votation_candidates_on_spotify_playlist_song_id"
    t.index ["votation_id"], name: "index_votation_candidates_on_votation_id"
  end

  create_table "votations", force: :cascade do |t|
    t.boolean "in_progress", null: false
    t.boolean "queued", null: false
    t.datetime "scheduled_start_for", precision: nil, null: false
    t.datetime "scheduled_start_at", precision: nil, null: false
    t.datetime "scheduled_end_for", precision: nil, null: false
    t.datetime "scheduled_end_at", precision: nil, null: false
    t.datetime "scheduled_close_for", precision: nil, null: false
    t.datetime "started_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "ongoing_playlist_id", null: false
    t.bigint "account_id", null: false
    t.index ["account_id", "ongoing_playlist_id"], name: "index_votations_on_account_id_and_ongoing_playlist_id"
    t.index ["account_id"], name: "index_votations_on_account_id"
    t.index ["ongoing_playlist_id"], name: "index_votations_on_ongoing_playlist_id"
  end

  add_foreign_key "ongoing_playlists", "accounts"
  add_foreign_key "ongoing_playlists", "spotify_playlist_songs", column: "playing_song_id"
  add_foreign_key "ongoing_playlists", "spotify_playlists"
  add_foreign_key "spotify_playlist_songs", "spotify_playlists"
  add_foreign_key "spotify_playlist_songs", "spotify_songs"
  add_foreign_key "spotify_playlists", "accounts"
  add_foreign_key "spotify_playlists", "spotify_users"
  add_foreign_key "spotify_users", "accounts"
  add_foreign_key "votation_candidates", "accounts"
  add_foreign_key "votation_candidates", "ongoing_playlists"
  add_foreign_key "votation_candidates", "spotify_playlist_songs"
  add_foreign_key "votation_candidates", "votations"
  add_foreign_key "votations", "accounts"
  add_foreign_key "votations", "ongoing_playlists"
end
