class AddPickupProductToSpreeProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_products, :is_pickup, :boolean, default: false
  end
end
