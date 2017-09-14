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

ActiveRecord::Schema.define(version: 20170913142045) do

  create_table "avatar_taggings", force: :cascade do |t|
    t.integer "avatar_id", null: false
    t.integer "avatar_tag_id", null: false
    t.index ["avatar_id", "avatar_tag_id"], name: "index_avatar_taggings_on_avatar_id_and_avatar_tag_id"
    t.index ["avatar_id"], name: "index_avatar_taggings_on_avatar_id"
    t.index ["avatar_tag_id"], name: "index_avatar_taggings_on_avatar_tag_id"
  end

  create_table "avatar_tags", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "description", default: "", null: false
    t.index ["description"], name: "index_avatar_tags_on_description"
    t.index ["title"], name: "index_avatar_tags_on_title", unique: true
  end

  create_table "avatars", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "description", default: "", null: false
    t.string "image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_avatars_on_description"
    t.index ["image"], name: "index_avatars_on_image"
    t.index ["title"], name: "index_avatars_on_title"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "person_id", null: false
    t.integer "text_id"
    t.integer "stamp_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_messages_on_person_id"
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["stamp_id"], name: "index_messages_on_stamp_id"
    t.index ["text_id"], name: "index_messages_on_text_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name", null: false
    t.integer "icon_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["icon_id"], name: "index_people_on_icon_id"
    t.index ["name"], name: "index_people_on_name"
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
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_rooms_on_title"
  end

  create_table "stamp_taggings", force: :cascade do |t|
    t.integer "stamp_id", null: false
    t.integer "stamp_tag_id", null: false
    t.index ["stamp_id", "stamp_tag_id"], name: "index_stamp_taggings_on_stamp_id_and_stamp_tag_id", unique: true
    t.index ["stamp_id"], name: "index_stamp_taggings_on_stamp_id"
    t.index ["stamp_tag_id"], name: "index_stamp_taggings_on_stamp_tag_id"
  end

  create_table "stamp_tags", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "description", default: "", null: false
    t.index ["description"], name: "index_stamp_tags_on_description"
    t.index ["title"], name: "index_stamp_tags_on_title", unique: true
  end

  create_table "stamps", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "description", default: "", null: false
    t.string "image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_stamps_on_description"
    t.index ["image"], name: "index_stamps_on_image"
    t.index ["title"], name: "index_stamps_on_title"
  end

  create_table "texts", force: :cascade do |t|
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_rooms", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.index ["room_id"], name: "index_user_rooms_on_room_id"
    t.index ["user_id"], name: "index_user_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "organization", null: false
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
    t.index ["name"], name: "index_users_on_name"
    t.index ["organization"], name: "index_users_on_organization"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
