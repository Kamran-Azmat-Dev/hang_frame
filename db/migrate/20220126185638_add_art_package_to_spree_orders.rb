class AddArtPackageToSpreeOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_orders, :package_option, :string
  end
end
