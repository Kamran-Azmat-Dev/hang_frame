module Spree
  module V2
    module Storefront
      class MountColorSerializer < BaseSerializer
        set_type :mount_color

        has_many :mount_preview_images
      end
    end
  end
end
