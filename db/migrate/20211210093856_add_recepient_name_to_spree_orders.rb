class AddRecepientNameToSpreeOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_orders, :recepient_name, :string
  end
end
