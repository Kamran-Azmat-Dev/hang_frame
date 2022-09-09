class AddWidthFieldForMountTypeTable < ActiveRecord::Migration[6.1]
  def change
    add_column :mount_types, :width, :decimal, default: 0.0
  end
end
