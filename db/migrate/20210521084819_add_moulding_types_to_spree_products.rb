class AddMouldingTypesToSpreeProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_products, :moulding_type_id, :integer
  end
end
