module Frame
  class FrameVariantPresenter
    include Spree::BaseHelper
    include Rails.application.routes.url_helpers

    attr_reader :variant, :currency

    def initialize(variant, currency = 'GBP')
      @variant = variant
      @currency = currency
      @border_preview = variant.frame_preview_images.find { |e| e.name == Frame::PreviewImage::BORDER_PATTERN }
      @default_image = default_image_for_product_or_variant(variant)
      @frame_preview_viewbox = GetFramePreviewViewbox.new.call(default_image)
    end

    def color
      variant.option_value(Frame::Constants::COLOR_OPTION_TYPE)
    end

    def print_size
      variant.option_values.find { |e| e.option_type.name == Frame::Constants::PRINT_SIZE_OPTION_TYPE }
    end

    def print_size_id
      print_size.try(:id)
    end

    def print_size_name
      print_size.try(:name)
    end

    def price
      variant.price_in(currency).try(:amount)
    end

    def moulding_type_id
      variant.product.moulding_type_id
    end

    def frame_photo_url
      return '' unless default_image.present?

      url_for(default_image.url(:large))
    end

    def frame_photo_width
      return nil unless default_image.present?

      default_image.url(:large).blob.metadata['width']
    end

    def frame_photo_height
      return nil unless default_image.present?

      default_image.url(:large).blob.metadata['height']
    end

    def border_pattern_url
      return nil unless border_preview.present?

      url_for(border_preview.attachment)
    end

    def border_width
      return nil unless border_preview.present?

      border_preview.border_width
    end

    def border_pattern_repeats
      return nil unless border_preview.present?

      border_preview.border_pattern_repeats
    end

    def to_h
      {
        'variantId' => variant.id,
        'mouldingTypeId' => moulding_type_id,
        'color' => color,
        'printSizeId' => print_size_id,
        'printSizeName' => print_size_name,
        'price' => price,
        'isMaster' => variant.is_master?,
        'framePreviewConfiguration' => frame_preview_configuration_json,
        'framePhotoUrl' => frame_photo_url,
        'framePhotoWidth' => frame_photo_width,
        'framePhotoHeight' => frame_photo_height,
        'framePreviewX' => frame_preview_viewbox.x,
        'framePreviewY' => frame_preview_viewbox.y,
        'framePreviewWidth' => frame_preview_viewbox.width,
        'framePreviewHeight' => frame_preview_viewbox.height
      }
    end

    private

    attr_reader :default_image, :frame_preview_viewbox, :border_preview

    def frame_preview_configuration_json
      {
        'borderPattern' => border_pattern_url,
        'borderWidth' => border_width,
        'borderPatternRepeats' => border_pattern_repeats
      }
    end
  end
end
