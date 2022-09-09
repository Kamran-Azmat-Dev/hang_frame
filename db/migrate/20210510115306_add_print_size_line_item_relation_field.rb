class AddPrintSizeLineItemRelationField < ActiveRecord::Migration[6.1]
  def change
    remove_column :hang_photos, :line_item_id, if_exists: true

    add_column :spree_line_items, :hang_photo_id, :integer
    add_column :spree_line_items, :print_size_id, :integer

    add_index :spree_line_items, :hang_photo_id
    add_index :spree_line_items, :print_size_id
  end
end
