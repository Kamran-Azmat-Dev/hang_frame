class CreateMouldingTypePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :moulding_type_prices do |t|
      t.integer :print_size_id
      t.integer :moulding_type_id
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
