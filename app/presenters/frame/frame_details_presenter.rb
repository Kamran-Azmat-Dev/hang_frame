module Frame
  class FrameDetailsPresenter
    def initialize(product)
      @product = product
    end

    def to_h
      {
        'name' => product.name,
        'slug' => product.slug,
        'description' => product.description,
        'shortDescription' => product.short_description,
        'isCustom' => product.custom?,
        'isPickup' => product.is_pickup?,
        'isDonation' => product.is_donation?,
        'isWrapped' => product.is_gift_wrapped?,
        'allowFloatMount' => product.allow_float_mount?,
        'variant' => variant_presenter.to_h,
        'images' => images_presenter.to_h,
        'whatsIncluded' => product.whats_included ? product.whats_included.html_safe : "",
        'isPersonalizedStandard' => product.taxons.map(&:name).include?('Personalized'),
      }
    end

    private

    attr_reader :product

    def default_variant
      product.has_variants? ? product.variants.first : product.master
    end

    def variant_presenter
      Frame::FrameVariantPresenter.new(default_variant)
    end

    def images_presenter
      images = default_variant.images
      image_presenters = images.map { |e| Frame::ImagePresenter.new(e) }
      ListPresenter.new(image_presenters)
    end
  end
end
