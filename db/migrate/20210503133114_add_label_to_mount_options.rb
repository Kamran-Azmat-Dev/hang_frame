class AddLabelToMountOptions < ActiveRecord::Migration[6.1]
  def change
    add_column :mount_options, :label, :string
  end
end
