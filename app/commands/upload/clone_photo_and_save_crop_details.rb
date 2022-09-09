module Upload
  class ClonePhotoAndSaveCropDetails
    def call(original_hang_photo, crop_params)
      hang_photo = HangPhoto.create!(
        photo: Paperclip.io_adapters.for(original_hang_photo.photo),
        preview_photo: Paperclip.io_adapters.for(original_hang_photo.preview_photo),
        left: crop_params[:left],
        top: crop_params[:top],
        width: crop_params[:width],
        height: crop_params[:height],
        print_width: crop_params[:print_width],
        print_height: crop_params[:print_height],
        original_art_type_id: crop_params[:original_art_type_id],
        print_size_option_value_id: crop_params[:print_size_option_value_id],
        hang_type: crop_params[:type]
      )

      GenerateCropWorker.perform_async(hang_photo.id)

      hang_photo
    end
  end
end
