module Spree
  module V2
    module Storefront
      class FramePreviewImageSerializer < BaseSerializer
        set_type :frame_preview_image

        attributes :name, :border_width, :border_pattern_repeats

        attribute :border_pattern do |object|
          Rails.application.routes.url_helpers.url_for(object.attachment)
        end
      end
    end
  end
end
