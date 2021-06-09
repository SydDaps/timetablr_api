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

ActiveRecord::Schema.define(version: 2021_06_07_152653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "courses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.uuid "level_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "department_id", null: false
    t.uuid "time_table_id", null: false
    t.string "kind"
    t.index ["department_id"], name: "index_courses_on_department_id"
    t.index ["level_id"], name: "index_courses_on_level_id"
    t.index ["time_table_id"], name: "index_courses_on_time_table_id"
  end

  create_table "courses_lecturers", id: false, force: :cascade do |t|
    t.uuid "course_id"
    t.uuid "lecturer_id"
    t.index ["course_id"], name: "index_courses_lecturers_on_course_id"
    t.index ["lecturer_id"], name: "index_courses_lecturers_on_lecturer_id"
  end

  create_table "courses_time_tags", id: false, force: :cascade do |t|
    t.uuid "course_id"
    t.uuid "time_tag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_courses_time_tags_on_course_id"
    t.index ["time_tag_id"], name: "index_courses_time_tags_on_time_tag_id"
  end

  create_table "days", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "time_table_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "number"
    t.index ["time_table_id"], name: "index_days_on_time_table_id"
  end

  create_table "days_time_tags", id: false, force: :cascade do |t|
    t.uuid "day_id"
    t.uuid "time_tag_id"
    t.index ["day_id"], name: "index_days_time_tags_on_day_id"
    t.index ["time_tag_id"], name: "index_days_time_tags_on_time_tag_id"
  end

  create_table "departments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.uuid "time_table_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["time_table_id"], name: "index_departments_on_time_table_id"
  end

  create_table "lecturers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_lecturers_on_email", unique: true
  end

  create_table "lecturers_time_tables", id: false, force: :cascade do |t|
    t.uuid "lecturer_id"
    t.uuid "time_table_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lecturer_id"], name: "index_lecturers_time_tables_on_lecturer_id"
    t.index ["time_table_id"], name: "index_lecturers_time_tables_on_time_table_id"
  end

  create_table "levels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "time_table_id", null: false
    t.index ["time_table_id"], name: "index_levels_on_time_table_id"
  end

  create_table "meet_times", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "time_tag_id"
    t.time "start"
    t.time "end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["time_tag_id"], name: "index_meet_times_on_time_tag_id"
  end

  create_table "pairings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "schedule_id"
    t.uuid "course_id"
    t.uuid "meet_time_id"
    t.uuid "day_id"
    t.uuid "room_id"
    t.uuid "time_tag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_pairings_on_course_id"
    t.index ["day_id"], name: "index_pairings_on_day_id"
    t.index ["meet_time_id"], name: "index_pairings_on_meet_time_id"
    t.index ["room_id"], name: "index_pairings_on_room_id"
    t.index ["schedule_id"], name: "index_pairings_on_schedule_id"
    t.index ["time_tag_id"], name: "index_pairings_on_time_tag_id"
  end

  create_table "room_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "time_table_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "time_tag_id"
    t.index ["time_table_id"], name: "index_room_categories_on_time_table_id"
    t.index ["time_tag_id"], name: "index_room_categories_on_time_tag_id"
  end

  create_table "rooms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "time_table_id", null: false
    t.index ["time_table_id"], name: "index_rooms_on_time_table_id"
  end

  create_table "rooms_time_tags", id: false, force: :cascade do |t|
    t.uuid "time_tag_id"
    t.uuid "room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_rooms_time_tags_on_room_id"
    t.index ["time_tag_id"], name: "index_rooms_time_tags_on_time_tag_id"
  end

  create_table "schedules", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "time_table_id"
    t.float "fitness"
    t.integer "conflicts"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["time_table_id"], name: "index_schedules_on_time_table_id"
  end

  create_table "time_tables", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.string "category"
    t.uuid "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.index ["user_id"], name: "index_time_tables_on_user_id"
  end

  create_table "time_tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.interval "duration"
    t.time "start_at"
    t.time "end_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "time_table_id", null: false
    t.index ["time_table_id"], name: "index_time_tags_on_time_table_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "courses", "departments"
  add_foreign_key "courses", "levels"
  add_foreign_key "courses", "time_tables"
  add_foreign_key "courses_lecturers", "courses"
  add_foreign_key "courses_lecturers", "lecturers"
  add_foreign_key "courses_time_tags", "courses"
  add_foreign_key "courses_time_tags", "time_tags"
  add_foreign_key "days", "time_tables"
  add_foreign_key "days_time_tags", "days"
  add_foreign_key "days_time_tags", "time_tags"
  add_foreign_key "departments", "time_tables"
  add_foreign_key "levels", "time_tables"
  add_foreign_key "meet_times", "time_tags"
  add_foreign_key "pairings", "courses"
  add_foreign_key "pairings", "days"
  add_foreign_key "pairings", "meet_times"
  add_foreign_key "pairings", "rooms"
  add_foreign_key "pairings", "schedules"
  add_foreign_key "pairings", "time_tags"
  add_foreign_key "room_categories", "time_tables"
  add_foreign_key "room_categories", "time_tags"
  add_foreign_key "rooms", "time_tables"
  add_foreign_key "schedules", "time_tables"
  add_foreign_key "time_tables", "users"
  add_foreign_key "time_tags", "time_tables"
end
