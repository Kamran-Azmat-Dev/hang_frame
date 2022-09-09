module Frame
  class ImagePresenter
    include Rails.application.routes.url_helpers

    def initialize(image)
      @image = image
    end

    def thumbnail_url
      url_for(image.url(:pdp_thumbnail))
    end

    def large_url
      url_for(image.url(:zoomed))
    end

    def to_h
      {
        'id' => image.id,
        'thumbnailUrl' => thumbnail_url,
        'largeUrl' => large_url
      }
    end

    private

    attr_reader :image
  end
end
