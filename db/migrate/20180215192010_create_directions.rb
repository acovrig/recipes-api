class CreateDirections < ActiveRecord::Migration[5.1]
  def change
    create_table :directions do |t|
      t.references :recipe, foreign_key: true
      t.integer :step
      t.string :action

      t.timestamps
    end
  end
end
