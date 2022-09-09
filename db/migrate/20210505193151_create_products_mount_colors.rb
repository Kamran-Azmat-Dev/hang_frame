class CreateProductsMountColors < ActiveRecord::Migration[6.1]
  def change
    create_table :products_mount_colors do |t|
      t.integer :product_id
      t.integer :mount_color_id

      t.timestamps
    end
  end
end
