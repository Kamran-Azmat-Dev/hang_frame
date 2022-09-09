class AddWhatsIncludedToSpreeProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_products, :whats_included, :text
  end
end
