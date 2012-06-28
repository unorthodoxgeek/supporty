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

ActiveRecord::Schema.define(:version => 20120628075053) do

  create_table "support_messages", :force => true do |t|
    t.integer  "support_id"
    t.text     "body"
    t.string   "subject"
    t.string   "from_email"
    t.string   "from_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "agent",      :default => false
  end

  add_index "support_messages", ["support_id", "id"], :name => "index_support_messages_on_support_id_and_id"

  create_table "supports", :force => true do |t|
    t.string   "reason"
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.text     "support"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "meta_fields"
    t.string   "status"
    t.integer  "agent_id"
    t.integer  "rating"
  end

  add_index "supports", ["agent_id", "rating"], :name => "index_supports_on_agent_id_and_rating"
  add_index "supports", ["status", "agent_id"], :name => "index_supports_on_status_and_agent_id"

end
