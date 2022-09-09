# frozen_string_literal: true

module Api
  class BaseController < ::ApplicationController
    before_action :validate_hang_photo, only: :upload_photo
    before_action :validate_crop_details, only: %i[crop_photo edit_photo_crop]
    before_action :load_hang_photo, only: %i[photo crop_photo cropped_photo edit_photo_crop available_options]

    def validate_crop_details
      result = CropDetailsValidator.new.call(permitted_crop_params.to_hash)
      render json: { data: { errors: result.errors.to_h } }, status: 422 unless result.success?
    end

    def validate_hang_photo
      result = HangPhotoValidator.new.call(permitted_params.to_hash)
      render json: { data: { errors: result.errors.to_h } }, status: 422 unless result.success?
    end
  end
end
