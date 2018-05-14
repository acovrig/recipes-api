class AddFileToPictures < ActiveRecord::Migration[5.1]
  def up
    remove_column :pictures, :fname
    add_attachment :pictures, :pic
  end
  def down
    remove_attachment :pictures, :pic
  end
end
