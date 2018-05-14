class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.references :recipe, foreign_key: true
      t.string :fname, null: false, unique: true
      t.string :sum, null: false, unique: true
      t.integer :width, null: false
      t.integer :height, null: false
      t.integer :size
      t.string :caption

      t.timestamps
    end
  end
end
