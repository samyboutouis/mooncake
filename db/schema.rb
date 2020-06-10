# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_10_164139) do

  create_table "courserequests", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.integer "course_id", null: false
    t.index ["course_id"], name: "index_courserequests_on_course_id"
    t.index ["user_id"], name: "index_courserequests_on_user_id"
  end

  create_table "courserequests_questions", id: false, force: :cascade do |t|
    t.integer "courserequest_id", null: false
    t.integer "question_id", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses_prereqs", id: false, force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "prereq_id", null: false
  end

  create_table "courses_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "course_id", null: false
  end

  create_table "permissionnums", force: :cascade do |t|
    t.string "expire_date"
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "course_id", null: false
    t.integer "courserequest_id", null: false
    t.index ["course_id"], name: "index_permissionnums_on_course_id"
    t.index ["courserequest_id"], name: "index_permissionnums_on_courserequest_id"
  end

  create_table "prereqs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "question_type"
    t.string "question_text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "major"
    t.integer "grad_year"
    t.string "user_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "courserequests", "courses"
  add_foreign_key "courserequests", "users"
  add_foreign_key "permissionnums", "courserequests"
  add_foreign_key "permissionnums", "courses"
end
