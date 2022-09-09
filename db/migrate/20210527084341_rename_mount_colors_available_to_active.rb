class RenameMountColorsAvailableToActive < ActiveRecord::Migration[6.1]
  def change
    rename_column :mount_colors, :available, :active
  end
end
