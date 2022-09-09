module Upload
  class GeneratePreview
    def call(hang_photo)
      original_photo = Paperclip.io_adapters.for(hang_photo.photo)
      hang_photo.preview_photo = original_photo
      hang_photo.save!

      hang_photo.preview_ready!
    end
  end
end
