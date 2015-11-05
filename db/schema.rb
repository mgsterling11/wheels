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

ActiveRecord::Schema.define(version: 20151105134656) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "destinations", force: :cascade do |t|
    t.string "address"
    t.float  "latitude"
    t.float  "longitude"
  end

  create_table "historical_trips", force: :cascade do |t|
    t.decimal  "pickup_longitude"
    t.decimal  "pickup_latitude"
    t.decimal  "dropoff_longitude"
    t.decimal  "dropoff_latitude"
    t.decimal  "tip_amount"
    t.decimal  "total_amount"
    t.integer  "passenger_count"
    t.float    "trip_distance"
    t.datetime "tpep_pickup_datetime"
    t.datetime "tpep_dropoff_datetime"
    t.float    "extra"
    t.float    "fare_amount"
    t.float    "mta_tax"
    t.float    "payment_type"
    t.float    "ratecodeid"
    t.integer  "vendorid"
    t.float    "tolls_amount"
    t.string   "store_and_fwd_flag"
  end

  create_table "origins", force: :cascade do |t|
    t.string "address"
    t.float  "latitude"
    t.float  "longitude"
  end

  create_table "ubers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_trips", force: :cascade do |t|
    t.datetime "pickup_datetime"
    t.integer  "user_id"
    t.integer  "origin_id"
    t.integer  "destination_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
  end

end
