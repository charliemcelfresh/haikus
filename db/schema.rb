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

ActiveRecord::Schema.define(version: 20151022224121) do

  create_table "haiku_lines", force: :cascade do |t|
    t.integer  "line_id"
    t.integer  "haiku_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "haiku_lines", ["haiku_id"], name: "index_haiku_lines_on_haiku_id"
  add_index "haiku_lines", ["line_id"], name: "index_haiku_lines_on_line_id"

  create_table "haikus", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lines", force: :cascade do |t|
    t.integer  "haiku_id"
    t.string   "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "line_number"
  end

  add_index "lines", ["haiku_id"], name: "index_lines_on_haiku_id"

  create_table "sessions", force: :cascade do |t|
    t.string   "oauth_token"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.integer  "haiku_id"
    t.string   "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
