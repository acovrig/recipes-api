class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.references :recipe, foreign_key: true
      t.string :fname
      t.string :sum
      t.integer :width
      t.integer :height
      t.integer :size

      t.timestamps
    end
  end
end
