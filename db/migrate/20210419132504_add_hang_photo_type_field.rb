class AddHangPhotoTypeField < ActiveRecord::Migration[6.1]
  def change
    add_column :hang_photos, :hang_type, :integer
  end
end
