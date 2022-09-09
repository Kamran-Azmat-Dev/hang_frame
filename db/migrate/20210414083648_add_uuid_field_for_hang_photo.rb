class AddUuidFieldForHangPhoto < ActiveRecord::Migration[6.1]
  def change
  	add_column :hang_photos, :uuid, :string, index: true
  end
end
