class AddMountColorIdToSpreeLineItems < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_line_items, :mount_color_id, :integer

    add_index :spree_line_items, :mount_color_id
  end
end
