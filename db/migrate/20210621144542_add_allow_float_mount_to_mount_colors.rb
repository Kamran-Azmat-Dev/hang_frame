class AddAllowFloatMountToMountColors < ActiveRecord::Migration[6.1]
  def change
    add_column :mount_colors, :allow_float_mount, :boolean, default: false
  end
end
