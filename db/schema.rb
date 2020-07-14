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

ActiveRecord::Schema.define(version: 2020_06_23_154418) do

  create_table "answers", force: :cascade do |t|
    t.string "answer_text"
    t.integer "question_id", null: false
    t.integer "course_request_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_request_id"], name: "index_answers_on_course_request_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "course_requests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "course_id", null: false
    t.string "status"
    t.integer "priority"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_requests_on_course_id"
    t.index ["user_id"], name: "index_course_requests_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "department"
    t.string "course_number"
    t.string "section_number"
    t.integer "capacity"
    t.integer "seats_taken"
    t.string "term"
    t.boolean "published"
    t.boolean "primary"
    t.text "cross_listing", default: "--- []\n"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses_prereqs", id: false, force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "prereq_id", null: false
  end

  create_table "courses_questions", id: false, force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "question_id", null: false
  end

  create_table "courses_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "course_id", null: false
  end

  create_table "permission_numbers", force: :cascade do |t|
    t.integer "number"
    t.string "expire_date"
    t.boolean "used"
    t.integer "course_id", null: false
    t.integer "course_request_id"
    t.boolean "consent"
    t.boolean "reqs"
    t.boolean "capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_permission_numbers_on_course_id"
    t.index ["course_request_id"], name: "index_permission_numbers_on_course_request_id"
  end

  create_table "prereqs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "question_type"
    t.string "question_text"
    t.text "option", default: "--- []\n"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "major"
    t.string "grad_year"
    t.string "user_type"
    t.string "unique_id"
    t.string "net_id"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "answers", "course_requests"
  add_foreign_key "answers", "questions"
  add_foreign_key "course_requests", "courses"
  add_foreign_key "course_requests", "users"
  add_foreign_key "permission_numbers", "course_requests"
  add_foreign_key "permission_numbers", "courses"
end
