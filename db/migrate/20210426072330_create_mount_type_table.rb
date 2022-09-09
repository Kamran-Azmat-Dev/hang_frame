class CreateMountTypeTable < ActiveRecord::Migration[6.1]
  def change
    create_table :mount_types do |t|
      t.string :name
      t.string :label

      t.decimal :price, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
