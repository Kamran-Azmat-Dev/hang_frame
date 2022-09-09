class AddOriginalArtDeliveryPriceToSpreeOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_orders, :original_art_delivery_price, :integer, default: 10
  end
end
