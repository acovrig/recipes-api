class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name, unique: true
      t.bigint :created_by_id, null: false

      t.timestamps
    end
    add_foreign_key :categories, :users, column: :created_by_id
    add_index :categories, [:name, :created_by_id], unique: true, name: 'uq_category'
  end
end
