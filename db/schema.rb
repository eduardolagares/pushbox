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

ActiveRecord::Schema.define(version: 2021_05_10_225748) do

  create_table "devices", force: :cascade do |t|
    t.integer "provider_id", null: false
    t.integer "system_id", null: false
    t.string "external_identifier"
    t.string "provider_identifier", null: false
    t.json "extra_data", default: {}
    t.json "tags", default: []
    t.string "api_key", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider_id", "provider_identifier"], name: "index_devices_on_provider_id_and_provider_identifier", unique: true
    t.index ["provider_id"], name: "index_devices_on_provider_id"
    t.index ["system_id"], name: "index_devices_on_system_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "provider_id", null: false
    t.datetime "schedule_at", null: false
    t.string "title"
    t.string "subtitle"
    t.string "body"
    t.integer "body_type"
    t.json "data"
    t.string "tag"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "destiny_type"
    t.integer "destiny_id"
    t.boolean "read", default: false, null: false
    t.index ["destiny_type", "destiny_id"], name: "index_notifications_on_destiny"
    t.index ["parent_id", "destiny_id"], name: "index_notifications_on_parent_id_and_destiny_id_and_destiny_id", unique: true
    t.index ["parent_id"], name: "index_notifications_on_parent_id"
    t.index ["provider_id"], name: "index_notifications_on_provider_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name", null: false
    t.json "config", default: {}
    t.string "delivery_class_name", null: false
    t.string "label", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "topic_id", null: false
    t.integer "device_id", null: false
    t.boolean "canceled", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["device_id"], name: "index_subscriptions_on_device_id"
    t.index ["topic_id", "device_id"], name: "index_subscriptions_on_topic_id_and_device_id", unique: true
    t.index ["topic_id"], name: "index_subscriptions_on_topic_id"
  end

  create_table "systems", force: :cascade do |t|
    t.string "name", null: false
    t.string "label", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.string "label", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "external_identifier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "api_key", null: false
    t.integer "role", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "devices", "providers"
  add_foreign_key "devices", "systems"
  add_foreign_key "notifications", "notifications", column: "parent_id"
  add_foreign_key "notifications", "providers"
  add_foreign_key "subscriptions", "devices"
  add_foreign_key "subscriptions", "topics"
end
