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

ActiveRecord::Schema[7.0].define(version: 2023_02_17_213447) do
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

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "industry"
    t.integer "employee_nb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "room_nb", default: 100, null: false
    t.float "length_of_stay", default: 2.0, null: false
    t.float "load_factor", default: 70.0, null: false
  end

  create_table "footprints", force: :cascade do |t|
    t.boolean "certified"
    t.date "date"
    t.integer "ghg_target"
    t.integer "target_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.integer "gaz"
    t.integer "fioul"
    t.integer "essence"
    t.integer "gazole"
    t.integer "electricite"
    t.integer "clients_fr"
    t.integer "clients_int"
    t.integer "fournisseurs"
    t.integer "taille_batiments"
    t.float "scope_1", default: 0.0, null: false
    t.float "scope_2", default: 0.0, null: false
    t.float "scope_3", default: 0.0, null: false
    t.float "ghg_result"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "footprints", "companies"
  add_foreign_key "tasks", "footprints"
  add_foreign_key "tasks", "users", column: "owner_id"
  add_foreign_key "users", "companies"
end
