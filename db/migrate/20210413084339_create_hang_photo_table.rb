class CreateHangPhotoTable < ActiveRecord::Migration[6.1]
  def change
    create_table :hang_photos do |t|
      t.string :token, required: true

      t.integer :line_item_id, index: true
      t.integer :status

      t.timestamps
    end
  end
end
