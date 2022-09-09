class AddRecepientMessageToSpreeOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_orders, :recepient_message, :text
  end
end
