class AddPrintWidthAndPrintHeightToHangPhoto < ActiveRecord::Migration[6.1]
  def change
    add_column :hang_photos, :print_width, :decimal, precision: 10, scale: 2
    add_column :hang_photos, :print_height, :decimal, precision: 10, scale: 2
  end
end
