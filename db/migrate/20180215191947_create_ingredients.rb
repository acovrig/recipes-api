class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.references :recipe, foreign_key: true
      t.float :qty
      t.string :unit
      t.string :item
      t.text :note

      t.timestamps
    end
  end
end
