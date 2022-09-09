module CustomFrame
  class ChevronPresenter
    include Rails.application.routes.url_helpers

    def initialize(product)
      @product = product
    end

    def chevron_image
      default_variant.frame_preview_images.find { |e| e.name == Frame::PreviewImage::CHEVRON }
    end

    def chevron_image_url
      return nil unless chevron_image.present?

      url_for(chevron_image.attachment)
    end

    def to_h
      {
        'productSlug' => product.slug,
        'chevronImageUrl' => chevron_image_url
      }
    end

    private

    attr_reader :product

    def default_variant
      product.has_variants? ? product.variants.first : product.master
    end
  end
end
