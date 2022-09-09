module Checkout
  class UploadPresenter
    delegate :print_width, :print_height, :hang_type, :uuid, to: :hang_photo

    def initialize(hang_photo)
      @hang_photo = hang_photo
    end

    def cropped_photo_url
      return nil unless hang_photo.present? and hang_photo.cropped_photo.present?

      hang_photo.cropped_photo.url rescue nil
    end

    def to_h
      {
        'photoUrl' => cropped_photo_url,
        'uploadType' => hang_type,
        'printWidth' => print_width,
        'printHeight' => print_height,
        'uuid' => uuid
      }
    end

    private

    attr_reader :hang_photo
  end
end
