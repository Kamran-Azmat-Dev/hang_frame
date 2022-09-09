class CreateFrameSizeTable < ActiveRecord::Migration[6.1]
  def change
    create_table :sizes do |t|
      t.references :print_size
      t.string :name

      t.decimal :price, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
