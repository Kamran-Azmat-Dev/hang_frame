module Spree
  module V2
    module Storefront
      module ImageSerializerDecorator
        def self.prepended(base)
          base.attribute :position

          base.attribute :frame_preview_viewbox do |object|
            viewbox = GetFramePreviewViewbox.new.call(object)
            return nil unless viewbox

            viewbox.to_h
          end

          base.attribute :width do |object|
            object.url(:large).blob.metadata['width']
          end

          base.attribute :height do |object|
            object.url(:large).blob.metadata['height']
          end

          base.attribute :url do |object|
            Rails.application.routes.url_helpers.url_for(object.url(:large))
          end
        end
      end
    end
  end
end

::Spree::V2::Storefront::ImageSerializer.prepend(Spree::V2::Storefront::ImageSerializerDecorator)
