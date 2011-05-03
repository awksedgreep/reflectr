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

ActiveRecord::Schema.define(:version => 20110503022545) do

  create_table "current_stats", :force => true do |t|
    t.integer  "metric_id",    :limit => 10
    t.integer  "device_id",    :limit => 10
    t.string   "string_value"
    t.integer  "value",        :limit => 19
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "device_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", :force => true do |t|
    t.string   "name"
    t.string   "ip"
    t.string   "url"
    t.integer  "device_type_id", :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metric_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metrics", :force => true do |t|
    t.string   "name"
    t.integer  "pollgroup_id",   :limit => 10
    t.integer  "metric_type_id", :limit => 10
    t.integer  "data_type_id",   :limit => 10
    t.integer  "port",           :limit => 10
    t.string   "property"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pollgroups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "device_type_id", :limit => 10
    t.integer  "pollgroup_id",   :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stats", :force => true do |t|
    t.integer  "metric_id",    :limit => 10
    t.integer  "device_id",    :limit => 10
    t.string   "string_value"
    t.integer  "value",        :limit => 19
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
