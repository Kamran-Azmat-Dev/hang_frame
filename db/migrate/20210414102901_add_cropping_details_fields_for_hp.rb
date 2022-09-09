class AddCroppingDetailsFieldsForHp < ActiveRecord::Migration[6.1]
  def change
    add_column :hang_photos, :left, :integer, null: false, default: 0
    add_column :hang_photos, :right, :integer, null: false, default: 0
    add_column :hang_photos, :bottom, :integer, null: false, default: 0
    add_column :hang_photos, :top, :integer, null: false, default: 0
  end
end
