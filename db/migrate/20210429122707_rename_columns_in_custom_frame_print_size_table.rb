class RenameColumnsInCustomFramePrintSizeTable < ActiveRecord::Migration[6.1]
  def change
    rename_column :print_sizes, :width, :shortest_side
    rename_column :print_sizes, :height, :longest_side
  end
end
