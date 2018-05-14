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

ActiveRecord::Schema.define(version: 20180514002243) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "fk_rails_335fee1547"
    t.index ["name", "created_by_id"], name: "uq_category", unique: true
  end

  create_table "directions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "recipe_id", null: false
    t.integer "step", null: false
    t.string "action", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id", "step"], name: "uq_direction", unique: true
    t.index ["recipe_id"], name: "index_directions_on_recipe_id"
  end

  create_table "ingredients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "recipe_id", null: false
    t.float "qty", limit: 24
    t.string "unit"
    t.string "item", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id", "item"], name: "uq_ingredient", unique: true
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id"
  end

  create_table "notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "recipe_id", null: false
    t.text "note", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_notes_on_recipe_id"
  end

  create_table "pictures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "recipe_id"
    t.string "sum", null: false
    t.integer "width", null: false
    t.integer "height", null: false
    t.integer "size"
    t.string "caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pic_file_name"
    t.string "pic_content_type"
    t.integer "pic_file_size"
    t.datetime "pic_updated_at"
    t.bigint "uploaded_by_id"
    t.index ["recipe_id"], name: "index_pictures_on_recipe_id"
    t.index ["uploaded_by_id"], name: "fk_rails_5749680f63"
  end

  create_table "recipe_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "recipe_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_recipe_categories_on_category_id"
    t.index ["recipe_id", "category_id"], name: "uq_recipe_category", unique: true
    t.index ["recipe_id"], name: "index_recipe_categories_on_recipe_id"
  end

  create_table "recipes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "author_id", null: false
    t.integer "serving_size"
    t.string "serving_suggestion"
    t.float "rating", limit: 24
    t.string "privacy", default: "internal", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "fk_rails_08ee84afe6"
    t.index ["name", "author_id"], name: "uq_recipe", unique: true
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "provider"
    t.string "uid"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "utensils", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "recipe_id", null: false
    t.string "name", null: false
    t.integer "qty", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id", "name"], name: "uq_utensil", unique: true
    t.index ["recipe_id"], name: "index_utensils_on_recipe_id"
  end

  add_foreign_key "categories", "users", column: "created_by_id"
  add_foreign_key "directions", "recipes"
  add_foreign_key "ingredients", "recipes"
  add_foreign_key "notes", "recipes"
  add_foreign_key "pictures", "recipes"
  add_foreign_key "pictures", "users", column: "uploaded_by_id"
  add_foreign_key "recipe_categories", "categories"
  add_foreign_key "recipe_categories", "recipes"
  add_foreign_key "recipes", "users", column: "author_id"
  add_foreign_key "utensils", "recipes"
end
