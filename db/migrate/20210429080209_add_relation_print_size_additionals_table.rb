class AddRelationPrintSizeAdditionalsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :print_size_additionals do |t|
      t.belongs_to :print_size
      t.belongs_to :additional
    end
  end
end
