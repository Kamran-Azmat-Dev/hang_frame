class CreateMountPreviewImages < ActiveRecord::Migration[6.1]
  def change
    create_table :mount_preview_images do |t|
      t.integer :mount_color_id
      t.string :name

      t.timestamps
    end
  end
end
