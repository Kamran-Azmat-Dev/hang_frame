module Spree
  module V2
    module Storefront
      module VariantSerializerDecorator
        def self.prepended(base)
          base.has_many :frame_preview_images
        end
      end
    end
  end
end

::Spree::V2::Storefront::VariantSerializer.prepend(Spree::V2::Storefront::VariantSerializerDecorator)
