class AddOriginalArtPackagingToSpreeOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_orders, :original_art_packaging, :integer
  end
end
