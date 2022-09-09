class AddAllowFloatMountToSpreeProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_products, :allow_float_mount, :boolean, default: false
  end
end
