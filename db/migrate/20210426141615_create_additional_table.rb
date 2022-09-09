class CreateAdditionalTable < ActiveRecord::Migration[6.1]
  def change
    create_table :additionals do |t|
      t.string :name
      t.integer :presentation_type

      t.decimal :price, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
