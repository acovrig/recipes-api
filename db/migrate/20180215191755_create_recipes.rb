class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name, unique: true
      t.bigint :author_id, null: false
      t.integer :serving_size
      t.string :serving_suggestion
      t.float :rating
      t.string :privacy, null: false, default: 'internal'

      t.timestamps
    end
    add_foreign_key :recipes, :users, column: :author_id
    add_index :recipes, [:name, :author_id], unique: true, name: 'uq_recipe'
  end
end
