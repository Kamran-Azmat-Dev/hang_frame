# frozen_string_literal: true

module Api
  class HangPhotosController < BaseController
    def photo
      presenter = HangPhotoPresenter.new(@hang_photo)
      render json: { data: presenter.to_h }, status: 200
    end

    def upload_photo
      photo = HangPhoto.new(permitted_params)

      if photo.save
        GeneratePreviewWorker.perform_async(photo.id)
        render json: { data: { uuid: photo.uuid } }, status: 201
      else
        render json: { data: { errors: photo.errors.to_h } }, status: 422
      end
    end

    def crop_photo
      Upload::SaveCropDetails.new.call(@hang_photo, permitted_crop_params)

      render json: { data: { uuid: @hang_photo.uuid } }, status: 200
    end

    def edit_photo_crop
      cloned_photo = Upload::ClonePhotoAndSaveCropDetails.new.call(@hang_photo, permitted_crop_params)

      render json: { data: { uuid: cloned_photo.uuid } }, status: 200
    end

    def available_options
      options_presenter = CustomFrame::GetAvailableOptions.new.call(@hang_photo.print_width, @hang_photo.print_height)
      render json: { data: options_presenter.to_h }, status: 200
    end

    private

    def load_hang_photo
      @hang_photo ||= HangPhoto.find_by!(uuid: params[:uuid].to_s)
    rescue ActiveRecord::RecordNotFound => e
      render json: { data: { error: e.as_json } }, status: 404
    end
    

    def permitted_params
      params.permit(:photo)
    end

    def permitted_crop_params
      params.permit(
        :width, :height, :left, :top, :type, :print_size_option_value_id,
        :print_width, :print_height, :original_art_type_id
      )
    end
  end
end
