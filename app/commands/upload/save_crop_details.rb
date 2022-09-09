module Upload
  class SaveCropDetails
    def call(hang_photo, crop_params)
      hang_photo.update!(
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
    end
  end
end
