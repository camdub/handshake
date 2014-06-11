# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140611190641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_settings", force: true do |t|
    t.integer  "user_id"
    t.integer  "setting_id"
    t.boolean  "enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_settings", ["setting_id"], name: "index_account_settings_on_setting_id", using: :btree
  add_index "account_settings", ["user_id"], name: "index_account_settings_on_user_id", using: :btree

  create_table "profile_types", force: true do |t|
    t.string   "connection_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_profiles", force: true do |t|
    t.integer  "user_id"
    t.integer  "profile_type_id"
    t.boolean  "handshake_user_name"
    t.boolean  "full_name"
    t.boolean  "company"
    t.boolean  "title"
    t.boolean  "picture"
    t.boolean  "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_profiles", ["profile_type_id"], name: "index_user_profiles_on_profile_type_id", using: :btree
  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "user_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "password"
    t.string   "handshake_access_token"
    t.string   "linkedin_access_token"
    t.decimal  "current_latitude"
    t.decimal  "current_logitude"
    t.datetime "last_login_timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["id"], name: "index_users_on_id", using: :btree

end
