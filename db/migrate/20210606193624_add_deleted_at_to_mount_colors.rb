class AddDeletedAtToMountColors < ActiveRecord::Migration[6.1]
  def change
    add_column :mount_colors, :deleted_at, :datetime
  end
end
