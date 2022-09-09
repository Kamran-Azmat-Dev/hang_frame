class CreateFoilBlockingColors < ActiveRecord::Migration[6.1]
  def change
    create_table :foil_blocking_colors do |t|
      t.string :name
      t.string :display
      t.boolean :active, default: true
      t.integer :position, default: 0, null: false

      t.timestamps
    end
  end
end
