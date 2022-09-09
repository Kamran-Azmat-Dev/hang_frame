class RemoveTokenColumnFromHangPhoto < ActiveRecord::Migration[6.1]
  def change
    remove_column :hang_photos, :token
  end
end
