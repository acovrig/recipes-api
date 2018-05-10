class CreateUtensils < ActiveRecord::Migration[5.1]
  def change
    create_table :utensils do |t|
      t.references :recipe, foreign_key: true, null: false
      t.string :name, null: false
      t.integer :qty, null: false, default: 1

      t.timestamps
    end
    add_index :utensils, [:recipe_id, :name], unique: true, name: 'uq_utensil'
  end
end
