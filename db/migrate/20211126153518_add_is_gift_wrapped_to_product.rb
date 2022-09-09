class AddIsGiftWrappedToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_products, :is_gift_wrapped, :boolean, default: false
  end
end
