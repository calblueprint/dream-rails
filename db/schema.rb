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

ActiveRecord::Schema.define(version: 20180323184235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer "student_id"
    t.integer "course_id"
    t.string "date"
    t.integer "attendance_type", default: 0
    t.string "comment"
    t.boolean "is_synced", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "teacher_id1"
    t.string "teacher_id2"
    t.string "course_nickname"
    t.string "site"
    t.integer "program"
    t.string "notes"
  end

  create_table "courses_students", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses_teachers", id: false, force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "teacher_id", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "weekday"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_id"
    t.index ["course_id"], name: "index_sessions_on_course_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "birthday"
    t.string "address"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "primary_contact"
    t.string "primary_contact_phone"
    t.string "dream_id"
    t.boolean "is_active"
    t.integer "sex"
    t.string "facebook_name"
    t.string "notes"
    t.integer "document_type"
    t.integer "level"
    t.string "phone"
    t.string "phone_2"
    t.string "email"
    t.integer "primary_language", default: 0
    t.boolean "past_dream_participant", default: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "dream_id"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
  end

  add_foreign_key "sessions", "courses"
end
