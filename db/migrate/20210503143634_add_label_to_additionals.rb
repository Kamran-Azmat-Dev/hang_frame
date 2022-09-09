class AddLabelToAdditionals < ActiveRecord::Migration[6.1]
  def change
    add_column :additionals, :label, :string
  end
end
