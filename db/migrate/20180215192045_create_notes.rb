class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.references :recipe, foreign_key: true, null: false
      t.text :note, null: false

      t.timestamps
    end
  end
end
