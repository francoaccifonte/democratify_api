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

ActiveRecord::Schema.define(version: 2021_10_26_025502) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "playlists_id"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["name"], name: "index_accounts_on_name", unique: true
    t.index ["playlists_id"], name: "index_accounts_on_playlists_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "song_id"
    t.index ["song_id"], name: "index_playlists_on_song_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "title", null: false
    t.string "artist", null: false
    t.bigint "album"
    t.string "year"
    t.string "genre"
    t.jsonb "metadata", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["album"], name: "index_songs_on_album"
    t.index ["artist"], name: "index_songs_on_artist"
    t.index ["title"], name: "index_songs_on_title"
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

  add_foreign_key "accounts", "playlists", column: "playlists_id"
  add_foreign_key "playlists", "songs"
end
