class CreateUtensils < ActiveRecord::Migration[5.1]
  def change
    create_table :utensils do |t|
      t.references :recipe, foreign_key: true
      t.string :name
      t.integer :qty

      t.timestamps
    end
  end
end
