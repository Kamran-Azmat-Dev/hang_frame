class AddPositionToMountsColors < ActiveRecord::Migration[6.1]
  def change
    add_column :mount_colors, :position, :integer, default: 0, null: false
  end
end
