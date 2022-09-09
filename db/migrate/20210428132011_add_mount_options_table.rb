class AddMountOptionsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :mount_options do |t|
      t.string :name, index: true

      t.decimal :top, precision: 10, scale: 2, default: 0.0
      t.decimal :bottom, precision: 10, scale: 2, default: 0.0
      t.decimal :left, precision: 10, scale: 2, default: 0.0
      t.decimal :right, precision: 10, scale: 2, default: 0.0

      t.decimal :price, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
