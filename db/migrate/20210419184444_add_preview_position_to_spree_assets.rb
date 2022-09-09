class AddPreviewPositionToSpreeAssets < ActiveRecord::Migration[6.1]
  def change
    change_table :spree_assets do |t|
      t.integer :preview_position_left
      t.integer :preview_position_right
      t.integer :preview_position_top
      t.integer :preview_position_bottom
    end
  end
end
