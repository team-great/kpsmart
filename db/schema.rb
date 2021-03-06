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

ActiveRecord::Schema.define(version: 20160601005924) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.decimal  "latitude",   precision: 15, scale: 10, default: 0.0
    t.decimal  "longitude",  precision: 15, scale: 10, default: 0.0
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "mail_deliveries", force: :cascade do |t|
    t.string   "day"
    t.integer  "to_id"
    t.integer  "from_id"
    t.decimal  "weight"
    t.decimal  "volume"
    t.string   "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mail_deliveries_routes", id: false, force: :cascade do |t|
    t.integer "mail_delivery_id"
    t.integer "route_id"
  end

  create_table "routes", force: :cascade do |t|
    t.integer  "to_id"
    t.integer  "from_id"
    t.integer  "priority"
    t.string   "provider"
    t.decimal  "weight_cost"
    t.decimal  "volume_cost"
    t.decimal  "max_weight"
    t.decimal  "max_volume"
    t.decimal  "duration"
    t.integer  "frequency"
    t.string   "day"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.decimal  "weight_price"
    t.decimal  "volume_price"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
