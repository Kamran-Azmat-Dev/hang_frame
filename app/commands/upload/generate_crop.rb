module Upload
  class GenerateCrop
    def call(hang_photo)
      original_photo = Paperclip.io_adapters.for(hang_photo.preview_photo)
      hang_photo.cropped_photo = original_photo
      hang_photo.save!

      hang_photo.crop_ready!
    end
  end
end
