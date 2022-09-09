class CreateMountColors < ActiveRecord::Migration[6.1]
  def change
    create_table :mount_colors do |t|
      t.string :name
      t.string :presentation
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
