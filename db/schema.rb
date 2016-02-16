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

ActiveRecord::Schema.define(version: 20160208020516) do

  create_table "events", force: :cascade do |t|
    t.string   "title",                 null: false
    t.text     "description"
    t.datetime "event_date",            null: false
    t.datetime "voting_start_datetime", null: false
    t.datetime "voting_end_date",       null: false
  end

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

  create_table "restaurants_events", force: :cascade do |t|
    t.integer "restaurant_id"
    t.integer "event_id"
  end

  add_index "restaurants_events", ["event_id"], name: "index_restaurants_events_on_event_id"
  add_index "restaurants_events", ["restaurant_id"], name: "index_restaurants_events_on_restaurant_id"

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

  create_table "voters", force: :cascade do |t|
    t.string   "email",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "groups_id"
  end

  add_index "voters", ["groups_id"], name: "index_voters_on_groups_id"

  create_table "voters_events", force: :cascade do |t|
    t.integer "voter_id"
    t.integer "event_id"
  end

  add_index "voters_events", ["event_id"], name: "index_voters_events_on_event_id"
  add_index "voters_events", ["voter_id"], name: "index_voters_events_on_voter_id"

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