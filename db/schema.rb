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

ActiveRecord::Schema.define(version: 20161202180007) do

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "user_id"
  end

  create_table "cas", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "user_id"
  end

  create_table "event_series", force: :cascade do |t|
    t.integer  "frequency",  default: 1
    t.string   "period",     default: "monthly"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ca_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_series_id"
    t.integer  "ca_id"
  end

  add_index "events", ["event_series_id"], name: "index_events_on_event_series_id"

  create_table "spreadsheets", force: :cascade do |t|
    t.integer "month"
    t.integer "year"
    t.string  "spreadsheet_id"
    t.string  "link"
  end

  create_table "timeslots", force: :cascade do |t|
    t.datetime "starttime"
    t.integer  "ca_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "new_schedule_email_sent", default: false
    t.boolean  "cancellation_sent",       default: false
    t.datetime "endtime"
  end

end
