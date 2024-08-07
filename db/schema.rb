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

ActiveRecord::Schema[7.1].define(version: 2024_08_07_004103) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "service"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "status"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_contracts_on_company_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "start_hour"
    t.datetime "end_hour"
    t.integer "duration"
    t.boolean "weekend"
    t.bigint "contract_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_schedules_on_contract_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.datetime "start_hour", null: false
    t.datetime "end_hour", null: false
    t.boolean "is_confirmed", default: false
    t.bigint "user_id", null: false
    t.bigint "schedule_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "week"
    t.index ["company_id"], name: "index_shifts_on_company_id"
    t.index ["schedule_id"], name: "index_shifts_on_schedule_id"
    t.index ["user_id"], name: "index_shifts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest", null: false
    t.string "role", default: "engineer"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "contracts", "companies"
  add_foreign_key "schedules", "contracts"
  add_foreign_key "shifts", "companies"
  add_foreign_key "shifts", "schedules"
  add_foreign_key "shifts", "users"
end
