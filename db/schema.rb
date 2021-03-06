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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130511205327) do

  create_table "activities", :force => true do |t|
    t.integer  "activity_type"
    t.decimal  "cost"
    t.string   "name"
    t.text     "notes"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "place_id"
  end

  create_table "activity_types", :force => true do |t|
    t.string   "activity_type"
    t.string   "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.text     "notes"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "trip_id"
    t.integer  "seq_no"
    t.date     "arrival_date"
    t.integer  "days"
    t.boolean  "active",       :default => true
    t.integer  "parent_id"
  end

  create_table "routes", :force => true do |t|
    t.integer  "trip_id"
    t.text     "notes"
    t.integer  "distance"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "seq_no"
    t.integer  "start_place_id"
    t.integer  "end_place_id"
    t.boolean  "active",         :default => true
    t.string   "drive_time"
  end

  create_table "trips", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.date     "start_date"
    t.date     "end_date"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
