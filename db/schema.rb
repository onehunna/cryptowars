# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160818033538) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "asset_values", force: :cascade do |t|
    t.integer  "asset_id"
    t.decimal  "price"
    t.decimal  "market_cap"
    t.decimal  "price_diff"
    t.decimal  "price_diff_percent"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["asset_id"], name: "index_asset_values_on_asset_id", using: :btree
  end

  create_table "assets", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_assets_on_code", unique: true, using: :btree
  end

  create_table "index_values", force: :cascade do |t|
    t.integer  "index_id"
    t.decimal  "value"
    t.decimal  "value_diff"
    t.decimal  "value_diff_percent"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["index_id"], name: "index_index_values_on_index_id", using: :btree
  end

  create_table "indices", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.decimal  "value"
    t.decimal  "value_diff_1h"
    t.decimal  "value_diff_24h"
    t.decimal  "value_diff_7d"
    t.integer  "rank"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["user_id"], name: "index_indices_on_user_id", using: :btree
  end

  create_table "positions", force: :cascade do |t|
    t.integer  "asset_id"
    t.integer  "index_id"
    t.decimal  "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asset_id", "index_id"], name: "index_positions_on_asset_id_and_index_id", unique: true, using: :btree
    t.index ["index_id"], name: "index_positions_on_index_id", using: :btree
  end

  create_table "user_identities", force: :cascade do |t|
    t.string   "provider"
    t.string   "email"
    t.string   "provider_user_id"
    t.string   "user_id"
    t.string   "username"
    t.string   "access_token"
    t.string   "refresh_token"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["provider", "provider_user_id"], name: "index_user_identities_on_provider_and_provider_user_id", unique: true, using: :btree
    t.index ["provider_user_id"], name: "index_user_identities_on_provider_user_id", using: :btree
    t.index ["user_id"], name: "index_user_identities_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "remember_created_at"
    t.string   "remember_token"
    t.string   "avatar_url"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

end
