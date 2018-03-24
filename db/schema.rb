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

ActiveRecord::Schema.define(version: 20180216025541) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "directions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "recipe_id", null: false
    t.integer "step", null: false
    t.string "action", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id", "step"], name: "index_directions_on_recipe_id_and_step", unique: true
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
    t.index ["recipe_id", "item"], name: "index_ingredients_on_recipe_id_and_item", unique: true
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id"
  end

  create_table "notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "recipe_id"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_notes_on_recipe_id"
  end

  create_table "pictures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "recipe_id"
    t.string "fname"
    t.string "sum"
    t.integer "width"
    t.integer "height"
    t.integer "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_pictures_on_recipe_id"
  end

  create_table "recipe_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "recipe_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_recipe_categories_on_category_id"
    t.index ["recipe_id"], name: "index_recipe_categories_on_recipe_id"
  end

  create_table "recipes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "author"
    t.integer "serving_size"
    t.string "serving_suggestion"
    t.float "rating", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "utensils", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "recipe_id"
    t.string "name"
    t.integer "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id", "name"], name: "uq_utensil", unique: true
    t.index ["recipe_id"], name: "index_utensils_on_recipe_id"
  end

  add_foreign_key "directions", "recipes"
  add_foreign_key "ingredients", "recipes"
  add_foreign_key "notes", "recipes"
  add_foreign_key "pictures", "recipes"
  add_foreign_key "recipe_categories", "categories"
  add_foreign_key "recipe_categories", "recipes"
  add_foreign_key "utensils", "recipes"
end
