class AddFeaturedToSpreeProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_products, :featured, :boolean
  end
end
