class AddFlagVisibleForCustomPrintSizeTable < ActiveRecord::Migration[6.1]
  def change
    add_column :print_sizes, :visible, :boolean, default: false
  end
end
