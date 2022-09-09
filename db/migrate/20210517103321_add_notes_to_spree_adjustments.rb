class AddNotesToSpreeAdjustments < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_adjustments, :notes, :string
  end
end
