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

ActiveRecord::Schema.define(:version => 20111218174836) do

  create_table "locations", :force => true do |t|
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.decimal  "latitude",          :precision => 15, :scale => 10
    t.decimal  "longitude",         :precision => 15, :scale => 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subscribers_count",                                 :default => 0, :null => false
  end

  add_index "locations", ["subscribers_count"], :name => "index_locations_on_subscribers_count"

  create_table "subscribers", :force => true do |t|
    t.string   "email",       :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscribers", ["email"], :name => "index_subscribers_on_email"

end
