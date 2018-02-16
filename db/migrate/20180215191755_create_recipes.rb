class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name, unique: true
      t.string :author
      t.integer :serving_size
      t.string :serving_suggestion
      t.float :rating

      t.timestamps
    end
  end
end
