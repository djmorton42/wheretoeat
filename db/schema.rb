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

ActiveRecord::Schema.define(version: 20160310212000) do

  create_table "events", force: :cascade do |t|
    t.string   "title",                 null: false
    t.text     "description"
    t.datetime "event_datetime",        null: false
    t.datetime "voting_start_datetime", null: false
    t.datetime "voting_end_datetime",   null: false
    t.integer  "group_id"
  end

  add_index "events", ["group_id"], name: "index_events_on_group_id"

  create_table "events_restaurants", id: false, force: :cascade do |t|
    t.integer "event_id",      null: false
    t.integer "restaurant_id", null: false
  end

  add_index "events_restaurants", ["event_id"], name: "index_events_restaurants_on_event_id"
  add_index "events_restaurants", ["restaurant_id"], name: "index_events_restaurants_on_restaurant_id"

  create_table "events_voters", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "voter_id", null: false
  end

  add_index "events_voters", ["event_id"], name: "index_events_voters_on_event_id"
  add_index "events_voters", ["voter_id"], name: "index_events_voters_on_voter_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id"

  create_table "restaurants", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "address"
    t.integer  "victory_count", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  add_index "restaurants", ["group_id"], name: "index_restaurants_on_group_id"
  add_index "restaurants", ["name", "group_id"], name: "index_restaurants_on_name_and_group_id", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",         null: false
    t.string   "password_hash", null: false
    t.string   "salt",          null: false
    t.boolean  "is_active",     null: false
    t.datetime "last_login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "voter_event_keys", force: :cascade do |t|
    t.string   "key",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "voter_id"
    t.integer  "event_id"
  end

  add_index "voter_event_keys", ["event_id"], name: "index_voter_event_keys_on_event_id"
  add_index "voter_event_keys", ["voter_id"], name: "index_voter_event_keys_on_voter_id"

  create_table "voters", force: :cascade do |t|
    t.string   "email",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "voters", ["email"], name: "index_voters_on_email", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "rank",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "voters_id"
    t.integer  "events_id"
    t.integer  "restaurants_id"
  end

  add_index "votes", ["events_id"], name: "index_votes_on_events_id"
  add_index "votes", ["restaurants_id"], name: "index_votes_on_restaurants_id"
  add_index "votes", ["voters_id"], name: "index_votes_on_voters_id"

end
