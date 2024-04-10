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

ActiveRecord::Schema[7.1].define(version: 2024_04_09_013646) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "employment_histories", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "employer_id", null: false
    t.boolean "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_employment_histories_on_employer_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "correct_answer_id"
    t.index ["correct_answer_id"], name: "index_questions_on_correct_answer_id"
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.boolean "draft", default: true
    t.bigint "author_id"
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
  add_foreign_key "employment_histories", "companies", column: "employer_id"
  add_foreign_key "employment_histories", "users", column: "employee_id"
  add_foreign_key "questions", "answers", column: "correct_answer_id"
  add_foreign_key "questions", "quizzes"
  add_foreign_key "quizzes", "users", column: "author_id"
  add_foreign_key "reviews", "users", column: "reviewer_id"
  add_foreign_key "user_quizzes", "quizzes"
  add_foreign_key "user_quizzes", "users"
end
