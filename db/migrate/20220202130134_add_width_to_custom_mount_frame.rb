class AddWidthToCustomMountFrame < ActiveRecord::Migration[6.1]
  def change
    add_column :custom_mount_frames, :width, :decimal, default: 0.0
  end
end
