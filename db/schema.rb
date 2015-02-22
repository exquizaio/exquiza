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

ActiveRecord::Schema.define(version: 20150222132100) do

  create_table "choices", force: :cascade do |t|
    t.text     "content"
    t.boolean  "answer"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "response_id"
  end

  add_index "choices", ["question_id"], name: "index_choices_on_question_id"
  add_index "choices", ["response_id"], name: "index_choices_on_response_id"

  create_table "katex_prompts", force: :cascade do |t|
    t.text     "content"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "katex_prompts", ["question_id"], name: "index_katex_prompts_on_question_id"

  create_table "paragraph_prompts", force: :cascade do |t|
    t.text     "content"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "paragraph_prompts", ["question_id"], name: "index_paragraph_prompts_on_question_id"

  create_table "passage_prompts", force: :cascade do |t|
    t.integer  "passage_id"
    t.text     "content"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "passage_prompts", ["question_id"], name: "index_passage_prompts_on_question_id"

  create_table "passages", force: :cascade do |t|
    t.integer  "passage_prompts_id"
    t.string   "author"
    t.string   "source"
    t.text     "body"
    t.string   "title"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text     "directions"
    t.integer  "difficulty"
    t.integer  "grade_level"
    t.integer  "prompt_id"
    t.string   "prompt_type"
    t.integer  "choices_id"
    t.integer  "tests_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "responses_id"
  end

  create_table "questions_tests", force: :cascade do |t|
    t.integer "question_id"
    t.integer "test_id"
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "selected_choice_id"
    t.integer  "correct_choice_id"
    t.integer  "choices_id"
    t.integer  "test_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.boolean  "correct"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "test_configurations", force: :cascade do |t|
    t.integer  "number_of_questions"
    t.integer  "min_difficulty"
    t.integer  "max_difficulty"
    t.integer  "min_grade_level"
    t.integer  "max_grade_level"
    t.integer  "test_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string   "type"
    t.integer  "user_id"
    t.datetime "started_on"
    t.boolean  "started"
    t.datetime "finished_on"
    t.boolean  "finished"
    t.integer  "questions_id"
    t.boolean  "adaptive",              default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "test_configuration_id"
    t.string   "token"
    t.integer  "responses_id"
    t.integer  "position",              default: 0
  end

  add_index "tests", ["test_configuration_id"], name: "index_tests_on_test_configuration_id"
  add_index "tests", ["token"], name: "index_tests_on_token", unique: true
  add_index "tests", ["user_id"], name: "index_tests_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.integer  "grade"
    t.string   "school"
    t.integer  "tests_id"
    t.boolean  "admin",                  default: false
    t.boolean  "correct"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
