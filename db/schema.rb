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

ActiveRecord::Schema.define(version: 20151102203945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "historicaltrips", force: :cascade do |t|
    t.decimal  "Pickup_longitude"
    t.decimal  "Pickup_latitude"
    t.decimal  "Dropoff_longitude"
    t.decimal  "Dropoff_latitude"
    t.decimal  "Tip_amount"
    t.decimal  "Total_amount"
    t.datetime "pickup_datetime"
    t.datetime "dropoff_datetime"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
  end

  create_table "usertrips", force: :cascade do |t|
    t.decimal  "Pickup_longitude"
    t.decimal  "Pickup_latitude"
    t.decimal  "Dropoff_longitude"
    t.decimal  "Dropoff_latitude"
    t.datetime "pickup_datetime"
    t.integer  "user_id"
  end

end
