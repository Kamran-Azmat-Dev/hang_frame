class CreateFramePreviewImages < ActiveRecord::Migration[6.1]
  def change
    create_table :preview_images do |t|
      t.integer :variant_id
      t.string :name

      t.timestamps
    end
  end
end
