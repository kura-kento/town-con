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

ActiveRecord::Schema.define(version: 2019_08_03_045250) do

  create_table "events", force: :cascade do |t|
    t.date "date"
    t.boolean "deadline_men", default: true
    t.boolean "deadline_women", default: true
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "joins", force: :cascade do |t|
    t.integer "user_id"
    t.string "gender"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.string "title"
    t.integer "peple", default: 1
    t.string "image"
    t.integer "creator_id"
    t.boolean "permission", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "user_id"
    t.integer "matched_id"
    t.integer "evaluation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
  end

  create_table "pairs", force: :cascade do |t|
    t.text "men"
    t.text "women"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
  end

  create_table "users", force: :cascade do |t|
    t.string "gender"
    t.string "name"
    t.string "email"
    t.string "password"
    t.integer "age"
    t.text "like"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
