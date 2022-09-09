class AddRelationPrintSizeMountTypeTable < ActiveRecord::Migration[6.1]
  def change
    create_table :print_size_mount_types do |t|
      t.belongs_to :print_size
      t.belongs_to :mount_type
    end
  end
end
