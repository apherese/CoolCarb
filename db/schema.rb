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

ActiveRecord::Schema[7.0].define(version: 2023_02_04_155546) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "industry"
    t.integer "employee_nb"
    t.integer "kwh"
    t.integer "square_meter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "footprints", force: :cascade do |t|
    t.json "ghg_result"
    t.string "step"
    t.boolean "certified"
    t.date "date"
    t.integer "ghg_target"
    t.integer "target_year"
    t.boolean "target_commitment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_footprints_on_company_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.bigint "footprint_id", null: false
    t.integer "ghg_contribution"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "owner_id"
    t.index ["footprint_id"], name: "index_tasks_on_footprint_id"
    t.index ["owner_id"], name: "index_tasks_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "position"
    t.string "name"
    t.bigint "company_id"
    t.boolean "admin", default: false, null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "footprints", "companies"
  add_foreign_key "tasks", "footprints"
  add_foreign_key "tasks", "users", column: "owner_id"
  add_foreign_key "users", "companies"
end
