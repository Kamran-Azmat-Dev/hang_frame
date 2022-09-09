class AddPrintSizeOptionIdToSpreeLineItems < ActiveRecord::Migration[6.1]
  def change
    add_column :hang_photos, :print_size_option_value_id, :integer
  end
end
