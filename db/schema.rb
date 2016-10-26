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

<<<<<<< 51744cb7798017e2b914c2bb5623e23f12fc8445
ActiveRecord::Schema.define(version: 20161019224817) do

  create_table "schedulers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
=======
ActiveRecord::Schema.define(version: 20161026031149) do

  create_table "timeslot10s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot11s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot12s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot13s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot14s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot15s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot16s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot17s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot18s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot19s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot1s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot20s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot21s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot22s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot23s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot24s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot25s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot26s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot27s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot28s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot29s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot2s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot30s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot31s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot3s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot4s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot5s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot6s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot7s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot8s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "timeslot9s", force: :cascade do |t|
    t.string   "time"
    t.integer  "CA_id"
    t.string   "client_name"
    t.string   "phone_number"
    t.string   "apt_number"
    t.string   "current_tenant"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
>>>>>>> create 31 timeslot models and populate them with times
  end

end
