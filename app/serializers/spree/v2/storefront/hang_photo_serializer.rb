module Spree
  module V2
    module Storefront
      class HangPhotoSerializer < BaseSerializer
        set_type :hang_photo

        attributes :print_width, :print_height, :hang_type, :uuid

        attribute :url do |object|
          object.cropped_photo.url
        end
      end
    end
  end
end
