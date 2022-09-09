class AddAttachmentPreviewPhotoToHangPhotos < ActiveRecord::Migration[6.1]
  def self.up
    change_table :hang_photos do |t|
      t.attachment :preview_photo
    end
  end

  def self.down
    remove_attachment :hang_photos, :preview_photo
  end
end
