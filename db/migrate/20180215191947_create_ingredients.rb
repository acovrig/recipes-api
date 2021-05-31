class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.references :recipe, foreign_key: true, null: false
      t.string :qty
      t.string :unit
      t.string :item, null: false
      t.text :note

      t.timestamps
    end
    add_index :ingredients, %i[recipe_id item], unique: true, name: 'uq_ingredient'
  end
end
