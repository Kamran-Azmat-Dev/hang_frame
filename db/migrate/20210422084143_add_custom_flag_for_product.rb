class AddCustomFlagForProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_products, :custom, :boolean, default: false
  end
end
