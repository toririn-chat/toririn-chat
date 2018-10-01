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

ActiveRecord::Schema.define(version: 2017_09_13_142045) do

  create_table "avatar_group_users", force: :cascade do |t|
    t.integer "avatar_group_id", null: false
    t.integer "user_id", null: false
    t.index ["avatar_group_id", "user_id"], name: "index_avatar_group_users_on_avatar_group_id_and_user_id", unique: true
    t.index ["avatar_group_id"], name: "index_avatar_group_users_on_avatar_group_id"
    t.index ["user_id"], name: "index_avatar_group_users_on_user_id"
  end

  create_table "avatar_groups", force: :cascade do |t|
    t.string "name"
    t.string "author"
    t.text "url"
    t.string "license_name"
    t.text "license_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author"], name: "index_avatar_groups_on_author"
    t.index ["license_name"], name: "index_avatar_groups_on_license_name"
    t.index ["license_url"], name: "index_avatar_groups_on_license_url"
    t.index ["name"], name: "index_avatar_groups_on_name"
    t.index ["url"], name: "index_avatar_groups_on_url"
  end

  create_table "avatars", force: :cascade do |t|
    t.string "name"
    t.binary "content_data", limit: 10485760, null: false
    t.string "content_type", null: false
    t.integer "avatar_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["avatar_group_id"], name: "index_avatars_on_avatar_group_id"
    t.index ["name"], name: "index_avatars_on_name"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "person_id", null: false
    t.text "text"
    t.integer "sticker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_messages_on_person_id"
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["sticker_id"], name: "index_messages_on_sticker_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.integer "avatar_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["avatar_id"], name: "index_people_on_avatar_id"
    t.index ["name"], name: "index_people_on_name"
    t.index ["token"], name: "index_people_on_token", unique: true
  end

  create_table "person_messages", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "message_id", null: false
    t.boolean "like", default: false, null: false
    t.boolean "read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_person_messages_on_message_id"
    t.index ["person_id", "message_id"], name: "index_person_messages_on_person_id_and_message_id", unique: true
    t.index ["person_id"], name: "index_person_messages_on_person_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", default: "", null: false
    t.datetime "begin_at"
    t.datetime "end_at"
    t.string "token", null: false
    t.string "code"
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_rooms_on_active"
    t.index ["begin_at"], name: "index_rooms_on_begin_at"
    t.index ["code"], name: "index_rooms_on_code"
    t.index ["end_at"], name: "index_rooms_on_end_at"
    t.index ["name"], name: "index_rooms_on_name"
    t.index ["token"], name: "index_rooms_on_token", unique: true
  end

  create_table "sticker_groups", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.text "url"
    t.string "license_name"
    t.text "license_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author"], name: "index_sticker_groups_on_author"
    t.index ["license_name"], name: "index_sticker_groups_on_license_name"
    t.index ["license_url"], name: "index_sticker_groups_on_license_url"
    t.index ["title"], name: "index_sticker_groups_on_title"
    t.index ["url"], name: "index_sticker_groups_on_url"
  end

  create_table "stickers", force: :cascade do |t|
    t.string "image", null: false
    t.integer "sticker_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sticker_group_id"], name: "index_stickers_on_sticker_group_id"
  end

  create_table "user_rooms", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.index ["room_id"], name: "index_user_rooms_on_room_id"
    t.index ["user_id"], name: "index_user_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "person_name", default: "", null: false
    t.string "organization_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_name"], name: "index_users_on_organization_name"
    t.index ["person_name"], name: "index_users_on_person_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
