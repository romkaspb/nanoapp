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

ActiveRecord::Schema.define(version: 20170311113423) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", id: false, force: :cascade do |t|
    t.integer  "user_id"
    t.string   "access_token"
    t.datetime "expires_at"
    t.datetime "last_access"
    t.datetime "created_at"
    t.boolean  "locked",       default: false
    t.index ["access_token"], name: "index_api_keys_on_access_token", unique: true, using: :btree
    t.index ["user_id"], name: "index_api_keys_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "messenger_id"
    t.text     "body"
    t.integer  "status_cd",             default: 0
    t.integer  "failed_delivery_count", default: 0
    t.datetime "delivered_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["messenger_id"], name: "index_messages_on_messenger_id", using: :btree
    t.index ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
    t.index ["sender_id", "recipient_id"], name: "index_messages_on_sender_id_and_recipient_id", using: :btree
    t.index ["sender_id"], name: "index_messages_on_sender_id", using: :btree
  end

  create_table "messengers", force: :cascade do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_identifiers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "messenger_id"
    t.string   "identifier"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["messenger_id"], name: "index_user_identifiers_on_messenger_id", using: :btree
    t.index ["user_id", "messenger_id"], name: "index_user_identifiers_on_user_id_and_messenger_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_user_identifiers_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "api_keys", "users"
end
