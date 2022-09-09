module Spree
  module V2
    module Storefront
      class AccentMountColorSerializer < BaseSerializer
        set_type :accent_mount_color

        has_many :mount_preview_images
      end
    end
  end
end
