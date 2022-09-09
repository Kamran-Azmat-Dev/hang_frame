class AddIsDonationFlagToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_products, :is_donation, :boolean, default: false
  end
end
