class AddFileFieldForHangPhoto < ActiveRecord::Migration[6.1]
  def change
    add_attachment :hang_photos, :photo
  end
end
