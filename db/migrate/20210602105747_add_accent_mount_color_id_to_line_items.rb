class AddAccentMountColorIdToLineItems < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_line_items, :accent_mount_color_id, :integer

    add_index :spree_line_items, :accent_mount_color_id
  end
end
