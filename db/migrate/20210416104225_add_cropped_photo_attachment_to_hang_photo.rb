class AddCroppedPhotoAttachmentToHangPhoto < ActiveRecord::Migration[6.1]
  def change
    add_attachment :hang_photos, :cropped_photo
  end
end
