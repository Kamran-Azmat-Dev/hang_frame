class RemoveCustomFrameSizeTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :sizes
  end
end
