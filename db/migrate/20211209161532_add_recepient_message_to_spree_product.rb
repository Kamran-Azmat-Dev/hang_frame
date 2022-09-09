class AddRecepientMessageToSpreeProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_products, :recepient_message, :text
  end
end
