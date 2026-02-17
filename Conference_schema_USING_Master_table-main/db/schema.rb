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

ActiveRecord::Schema[8.0].define(version: 2025_08_04_070743) do
  create_table "bagdes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "badge_type", null: false
    t.string "badge_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conference_categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conference_components", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conference_modes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_conference_modes_on_location_id"
  end

  create_table "conferences", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "theme"
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.string "image"
    t.string "status", default: "upcoming", null: false
    t.string "event_url"
    t.bigint "j_user_id", null: false
    t.bigint "conference_mode_id", null: false
    t.bigint "point_of_contact_id", null: false
    t.bigint "conference_component_id", null: false
    t.bigint "conference_category_id", null: false
    t.bigint "bagdes_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bagdes_id"], name: "index_conferences_on_bagdes_id"
    t.index ["conference_category_id"], name: "index_conferences_on_conference_category_id"
    t.index ["conference_component_id"], name: "index_conferences_on_conference_component_id"
    t.index ["conference_mode_id"], name: "index_conferences_on_conference_mode_id"
    t.index ["end_date"], name: "index_conferences_on_end_date"
    t.index ["j_user_id"], name: "index_conferences_on_j_user_id"
    t.index ["point_of_contact_id"], name: "index_conferences_on_point_of_contact_id"
    t.index ["start_date"], name: "index_conferences_on_start_date"
    t.index ["status"], name: "index_conferences_on_status"
    t.index ["title"], name: "index_conferences_on_title"
  end

  create_table "delayed_jobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "districts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enquire_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "j_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email"
    t.string "password"
  end

  create_table "locations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "address", null: false
    t.string "city", null: false
    t.string "pincode", null: false
    t.bigint "state_id", null: false
    t.bigint "district_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_locations_on_district_id"
    t.index ["state_id"], name: "index_locations_on_state_id"
  end

  create_table "person_details", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "point_of_contacts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "enquire_type_id", null: false
    t.bigint "person_detail_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enquire_type_id"], name: "index_point_of_contacts_on_enquire_type_id"
    t.index ["person_detail_id"], name: "index_point_of_contacts_on_person_detail_id"
  end

  create_table "posts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.string "content", null: false
    t.bigint "j_user_id", null: false
    t.string "posted_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["j_user_id"], name: "index_posts_on_j_user_id"
  end

  create_table "profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "designation"
    t.string "address"
    t.string "phone_number"
    t.string "profile_pic"
    t.string "pincode"
    t.bigint "j_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["j_user_id"], name: "index_profiles_on_j_user_id"
  end

  create_table "states", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "conference_modes", "locations"
  add_foreign_key "conferences", "bagdes", column: "bagdes_id"
  add_foreign_key "conferences", "conference_categories"
  add_foreign_key "conferences", "conference_components"
  add_foreign_key "conferences", "conference_modes"
  add_foreign_key "conferences", "j_users"
  add_foreign_key "conferences", "point_of_contacts"
  add_foreign_key "locations", "districts"
  add_foreign_key "locations", "states"
  add_foreign_key "point_of_contacts", "enquire_types"
  add_foreign_key "point_of_contacts", "person_details"
  add_foreign_key "posts", "j_users"
  add_foreign_key "profiles", "j_users"
end
