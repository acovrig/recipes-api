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

ActiveRecord::Schema.define(version: 2021_05_30_210707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 255
    t.bigint "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "idx_69175_fk_rails_335fee1547"
    t.index ["name", "created_by_id"], name: "idx_69175_uq_category", unique: true
  end

  create_table "directions", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "step", null: false
    t.string "action", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id", "step"], name: "idx_69181_uq_direction", unique: true
    t.index ["recipe_id"], name: "idx_69181_index_directions_on_recipe_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.string "qty", limit: 255
    t.string "unit", limit: 255
    t.string "item", limit: 255, null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id", "item"], name: "idx_69187_uq_ingredient", unique: true
    t.index ["recipe_id"], name: "idx_69187_index_ingredients_on_recipe_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.text "note", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "idx_69196_index_notes_on_recipe_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.bigint "recipe_id"
    t.string "sum", limit: 255, null: false
    t.bigint "width", null: false
    t.bigint "height", null: false
    t.bigint "size"
    t.string "caption", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pic_file_name", limit: 255
    t.string "pic_content_type", limit: 255
    t.bigint "pic_file_size"
    t.datetime "pic_updated_at"
    t.bigint "uploaded_by_id"
    t.index ["recipe_id"], name: "idx_69205_index_pictures_on_recipe_id"
    t.index ["uploaded_by_id"], name: "idx_69205_fk_rails_5749680f63"
  end

  create_table "recipe_categories", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "idx_69224_index_recipe_categories_on_category_id"
    t.index ["recipe_id", "category_id"], name: "idx_69224_uq_recipe_category", unique: true
    t.index ["recipe_id"], name: "idx_69224_index_recipe_categories_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name", limit: 255
    t.bigint "author_id", null: false
    t.bigint "servings"
    t.string "serving_suggestion", limit: 255
    t.float "rating"
    t.string "privacy", limit: 255, default: "internal", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "idx_69214_fk_rails_08ee84afe6"
    t.index ["name", "author_id"], name: "idx_69214_uq_recipe", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "allow_password_change", default: false
    t.string "nickname"
    t.string "image"
    t.json "tokens"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "utensils", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.string "name", limit: 255, null: false
    t.bigint "qty", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id", "name"], name: "idx_69245_uq_utensil", unique: true
    t.index ["recipe_id"], name: "idx_69245_index_utensils_on_recipe_id"
  end

  add_foreign_key "categories", "users", column: "created_by_id", on_update: :restrict, on_delete: :restrict
  add_foreign_key "directions", "recipes", on_update: :restrict, on_delete: :restrict
  add_foreign_key "ingredients", "recipes", on_update: :restrict, on_delete: :restrict
  add_foreign_key "notes", "recipes", on_update: :restrict, on_delete: :restrict
  add_foreign_key "pictures", "recipes", on_update: :restrict, on_delete: :restrict
  add_foreign_key "pictures", "users", column: "uploaded_by_id", on_update: :restrict, on_delete: :restrict
  add_foreign_key "recipe_categories", "categories", on_update: :restrict, on_delete: :restrict
  add_foreign_key "recipe_categories", "recipes", on_update: :restrict, on_delete: :restrict
  add_foreign_key "recipes", "users", column: "author_id", on_update: :restrict, on_delete: :restrict
  add_foreign_key "utensils", "recipes", on_update: :restrict, on_delete: :restrict
end
