class AddFoilBlockingToLineItems < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_line_items, :foil_blocking, :boolean, default: false
  end
end
