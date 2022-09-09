class AddDeletedAtToPrintSizes < ActiveRecord::Migration[6.1]
  def change
    add_column :print_sizes, :deleted_at, :datetime
  end
end
