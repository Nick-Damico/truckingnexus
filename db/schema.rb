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

ActiveRecord::Schema[7.2].define(version: 2025_04_27_035445) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "activity_type", ["on_duty", "driving", "off_duty", "sleeper"]

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answer_sheet_questions", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "answer_id"
    t.bigint "answer_sheet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_answer_sheet_questions_on_answer_id"
    t.index ["answer_sheet_id"], name: "index_answer_sheet_questions_on_answer_sheet_id"
    t.index ["id", "question_id"], name: "index_answer_sheet_questions_on_id_and_question_id", unique: true
    t.index ["question_id"], name: "index_answer_sheet_questions_on_question_id"
  end

  create_table "answer_sheets", force: :cascade do |t|
    t.bigint "user_quiz_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_quiz_id"], name: "index_answer_sheets_on_user_quiz_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "correct", default: false
    t.index ["correct"], name: "index_answers_on_correct"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "state"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_companies_on_name", unique: true
  end

  create_table "driver_logs", force: :cascade do |t|
    t.datetime "started_at", null: false
    t.datetime "ended_at", null: false
    t.bigint "driver_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "employee_number"
    t.integer "total_miles"
    t.integer "tractor_number"
    t.integer "trailer_number_1"
    t.integer "trailer_number_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_driver_logs_on_company_id"
    t.index ["driver_id"], name: "index_driver_logs_on_driver_id"
  end

  create_table "duty_statuses", force: :cascade do |t|
    t.bigint "driver_log_id", null: false
    t.enum "activity", null: false, enum_type: "activity_type"
    t.datetime "started_at", null: false
    t.datetime "ended_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_log_id"], name: "index_duty_statuses_on_driver_log_id"
  end

  create_table "employment_histories", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "employer_id", null: false
    t.boolean "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_employment_histories_on_employer_id"
  end

  create_table "geolocations", force: :cascade do |t|
    t.string "name"
    t.decimal "longitude", precision: 10, scale: 6
    t.decimal "latitude", precision: 10, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "geolocation_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geolocation_id"], name: "index_notes_on_geolocation_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.boolean "draft", default: true
    t.bigint "author_id", null: false
    t.index ["author_id"], name: "index_quizzes_on_author_id"
    t.index ["draft"], name: "index_quizzes_on_draft"
    t.index ["name"], name: "index_quizzes_on_name", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "reviewer_id", null: false
    t.integer "rating"
    t.text "content"
    t.string "title"
    t.string "reviewable_type", null: false
    t.bigint "reviewable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable"
    t.index ["reviewer_id", "reviewable_id", "reviewable_type"], name: "by_reviewer", unique: true
    t.index ["reviewer_id"], name: "index_reviews_on_reviewer_id"
  end

  create_table "user_quizzes", force: :cascade do |t|
    t.integer "score"
    t.bigint "user_id", null: false
    t.bigint "quiz_id", null: false
    t.datetime "completed_at"
    t.index ["quiz_id", "user_id"], name: "index_user_quizzes_on_quiz_id_and_user_id"
    t.index ["quiz_id"], name: "index_user_quizzes_on_quiz_id"
    t.index ["user_id", "quiz_id"], name: "index_user_quizzes_on_user_id_and_quiz_id"
    t.index ["user_id"], name: "index_user_quizzes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answer_sheet_questions", "answer_sheets"
  add_foreign_key "answer_sheet_questions", "answers"
  add_foreign_key "answer_sheet_questions", "questions"
  add_foreign_key "answer_sheets", "user_quizzes"
  add_foreign_key "answers", "questions"
  add_foreign_key "driver_logs", "companies"
  add_foreign_key "driver_logs", "users", column: "driver_id"
  add_foreign_key "duty_statuses", "driver_logs"
  add_foreign_key "employment_histories", "companies", column: "employer_id"
  add_foreign_key "employment_histories", "users", column: "employee_id"
  add_foreign_key "notes", "geolocations"
  add_foreign_key "notes", "users"
  add_foreign_key "questions", "quizzes"
  add_foreign_key "quizzes", "users", column: "author_id"
  add_foreign_key "reviews", "users", column: "reviewer_id"
  add_foreign_key "user_quizzes", "quizzes"
  add_foreign_key "user_quizzes", "users"
end
