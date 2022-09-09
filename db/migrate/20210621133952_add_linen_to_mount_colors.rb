class AddLinenToMountColors < ActiveRecord::Migration[6.1]
  def change
    add_column :mount_colors, :linen, :boolean, default: false
  end
end
