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

ActiveRecord::Schema.define(version: 20150405173456) do

  create_table "brands", force: true do |t|
    t.string   "name"
    t.string   "furigana"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "creaters", force: true do |t|
    t.string   "name"
    t.string   "furigana"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.string   "name"
    t.string   "furigana"
    t.string   "sellday"
    t.integer  "brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "model"
  end

  create_table "joins", force: true do |t|
    t.integer  "game_id"
    t.integer  "creater_id"
    t.integer  "role"
    t.integer  "role_detail"
    t.string   "role_detail_name", limit: 1023
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "story"
    t.integer  "cg"
    t.integer  "voice"
    t.integer  "system"
    t.integer  "hscene"
    t.integer  "total"
    t.integer  "has_link"
    t.string   "link"
    t.string   "comments",   limit: 2048
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "music"
  end

  create_table "tsumiges", force: true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "level",                  default: 0,  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
