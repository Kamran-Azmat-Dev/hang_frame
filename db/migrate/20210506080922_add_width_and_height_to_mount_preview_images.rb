class AddWidthAndHeightToMountPreviewImages < ActiveRecord::Migration[6.1]
  def change
    add_column :mount_preview_images, :width, :decimal, precision: 10, scale: 2
    add_column :mount_preview_images, :height, :decimal, precision: 10, scale: 2
  end
end
