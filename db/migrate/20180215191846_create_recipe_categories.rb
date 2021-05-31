class CreateRecipeCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_categories do |t|
      t.references :recipe, foreign_key: true, null: false
      t.references :category, foreign_key: true, null: false

      t.timestamps
    end
    add_index :recipe_categories, %i[recipe_id category_id], unique: true, name: 'uq_recipe_category'
  end
end
