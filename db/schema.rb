# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_10_153850) do
  create_table "bookmarks", force: :cascade do |t|
    t.text "location"
    t.string "title"
    t.text "description"
    t.text "image_url"
    t.datetime "last_visited"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "collection", default: 0
  end

  create_table "collections", force: :cascade do |t|
    t.string "title"
    t.integer "parent_collection"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
  end

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.string "device_guid"
    t.text "info"
    t.boolean "enabled"
    t.boolean "need_confirmation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string "doc_type"
    t.string "title"
    t.text "description"
    t.text "location"
    t.integer "collection"
    t.datetime "last_visited"
    t.text "content"
    t.text "image_url"
    t.text "tags"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "import_bookmarks", force: :cascade do |t|
    t.text "location"
    t.boolean "processed"
    t.boolean "queued"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count"
    t.integer "total"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "device"
    t.string "token"
    t.datetime "limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
