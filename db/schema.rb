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

ActiveRecord::Schema.define(version: 20140709101200) do

  create_table "abuses", force: true do |t|
    t.integer  "comment_id"
    t.string   "verify_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "subject_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "teacher_id"
  end

  add_index "comments", ["id", "subject_id", "user_id"], name: "index_comments_on_id_and_subject_id_and_teacher_id_and_user_id"

  create_table "departments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.integer  "review"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.integer  "teacher_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["id", "teacher_id"], name: "index_subjects_on_id_and_teacher_id"

  create_table "teachers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id", limit: 255
    t.string   "avatar"
  end

  add_index "teachers", ["id", "department_id"], name: "index_teachers_on_id_and_department_id"

  create_table "tests", force: true do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "review"
  end

  create_table "users", force: true do |t|
    t.integer  "type_id"
    t.integer  "platform_id"
    t.string   "ip"
    t.string   "email"
    t.string   "verify_code"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "student_id"
    t.string   "password"
  end

  add_index "users", ["id", "type_id", "platform_id"], name: "index_users_on_id_and_type_id_and_platform_id"

end
