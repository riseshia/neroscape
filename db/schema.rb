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

ActiveRecord::Schema.define(version: 20151225112450) do

  create_table "appearances", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "game_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "appearances", ["creator_id"], name: "index_appearances_on_creator_id"
  add_index "appearances", ["game_id"], name: "index_appearances_on_game_id"
  add_index "appearances", ["role_id"], name: "index_appearances_on_role_id"

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.string   "homepage_url"
    t.integer  "getchu_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.integer  "game_id"
    t.integer  "creator_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "characters", ["creator_id"], name: "index_characters_on_creator_id"
  add_index "characters", ["game_id"], name: "index_characters_on_game_id"

  create_table "creators", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string   "title"
    t.string   "poster_url"
    t.integer  "price"
    t.string   "genre"
    t.text     "story"
    t.integer  "brand_id"
    t.integer  "getchu_id"
    t.date     "release_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "page_hash"
  end

  add_index "games", ["brand_id"], name: "index_games_on_brand_id"

  create_table "rel_game_categories", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "rel_game_categories", ["category_id"], name: "index_rel_game_categories_on_category_id"
  add_index "rel_game_categories", ["game_id"], name: "index_rel_game_categories_on_game_id"

  create_table "rel_game_subgenres", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "subgenre_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "rel_game_subgenres", ["game_id"], name: "index_rel_game_subgenres_on_game_id"
  add_index "rel_game_subgenres", ["subgenre_id"], name: "index_rel_game_subgenres_on_subgenre_id"

  create_table "reviews", force: :cascade do |t|
    t.integer  "score"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["game_id"], name: "index_reviews_on_game_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stacks", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stacks", ["game_id"], name: "index_stacks_on_game_id"
  add_index "stacks", ["user_id"], name: "index_stacks_on_user_id"

  create_table "subgenres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.integer  "level",                  default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
