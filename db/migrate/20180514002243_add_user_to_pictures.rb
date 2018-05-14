class AddUserToPictures < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :uploaded_by_id, :bigint
    add_foreign_key :pictures, :users, column: :uploaded_by_id
  end
end
