class CreatePrintSizeTable < ActiveRecord::Migration[6.1]
  def change
    create_table :print_sizes do |t|
      t.string :name
      t.string :label

      t.integer :height, null: false, default: 0
      t.integer :width, null: false, default: 0

      t.timestamps
    end
  end
end
