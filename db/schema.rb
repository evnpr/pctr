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

ActiveRecord::Schema.define(:version => 20130623170723) do

  create_table "comments", :force => true do |t|
    t.text     "message"
    t.integer  "site_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "issues", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "issuesites", :force => true do |t|
    t.integer  "site_id"
    t.integer  "issue_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "komentars", :force => true do |t|
    t.integer  "issue_id"
    t.text     "message"
    t.integer  "bermutu",    :default => 0
    t.integer  "biasa",      :default => 0
    t.integer  "gakmutu",    :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "user_id"
  end

  create_table "sites", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "image_url"
    t.string   "host"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "image_url"
    t.integer  "biasa",      :default => 0
    t.integer  "bermutu",    :default => 0
    t.integer  "gakmutu",    :default => 0
  end

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "komentar_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "vote"
  end

end
