class AddMountTypePreferencesForCustomTypeTable < ActiveRecord::Migration[6.1]
  def change
    create_table :custom_preferences do |t|
      t.belongs_to :mount_type

      t.integer :min_value
      t.integer :max_value

      t.decimal :default_size, precision: 10, scale: 2
      t.decimal :price, precision: 10, scale: 2, default: 0.0, null: false
    end
  end
end
