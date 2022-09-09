class AddMountDimensionsToSpreeAdjustments < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_adjustments, :mount_top, :decimal, precision: 10, scale: 2
    add_column :spree_adjustments, :mount_left, :decimal, precision: 10, scale: 2
    add_column :spree_adjustments, :mount_bottom, :decimal, precision: 10, scale: 2
    add_column :spree_adjustments, :mount_right, :decimal, precision: 10, scale: 2
  end
end
