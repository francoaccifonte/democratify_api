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

ActiveRecord::Schema.define(version: 2021_10_26_233713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["name"], name: "index_accounts_on_name", unique: true
  end

  create_table "integrations", force: :cascade do |t|
    t.string "provider", null: false
    t.string "token"
    t.string "uuid", null: false
    t.string "email"
    t.string "name"
    t.jsonb "metadata", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id"
    t.bigint "user_id"
    t.index ["account_id"], name: "index_integrations_on_account_id"
    t.index ["provider", "token", "uuid"], name: "index_integrations_on_provider_and_token_and_uuid"
    t.index ["user_id"], name: "index_integrations_on_user_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "provider"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id"
    t.index ["account_id"], name: "index_playlists_on_account_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "title", null: false
    t.string "artist", null: false
    t.string "album"
    t.bigint "year"
    t.string "genre"
    t.jsonb "metadata", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "playlist_id"
    t.index ["album"], name: "index_songs_on_album"
    t.index ["artist"], name: "index_songs_on_artist"
    t.index ["playlist_id"], name: "index_songs_on_playlist_id"
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

  add_foreign_key "integrations", "accounts"
  add_foreign_key "integrations", "users"
  add_foreign_key "playlists", "accounts"
  add_foreign_key "songs", "playlists"
end
