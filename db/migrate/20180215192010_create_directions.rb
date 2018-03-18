class CreateDirections < ActiveRecord::Migration[5.1]
  def change
    create_table :directions do |t|
      t.references :recipe, foreign_key: true, null: false
      t.integer :step, null: false
      t.string :action, null: false

      t.timestamps
    end
    add_index :directions, [:recipe_id, :step], unique: true
  end
end
