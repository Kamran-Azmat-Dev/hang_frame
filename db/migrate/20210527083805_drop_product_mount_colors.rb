class DropProductMountColors < ActiveRecord::Migration[6.1]
  def change
    drop_table :products_mount_colors
  end
end
