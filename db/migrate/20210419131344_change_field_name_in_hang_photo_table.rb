class ChangeFieldNameInHangPhotoTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :hang_photos, :right, :integer
    remove_column :hang_photos, :bottom, :integer

    add_column :hang_photos, :width, :integer, null: false, default: 0
    add_column :hang_photos, :height, :integer, null: false, default: 0
  end
end
